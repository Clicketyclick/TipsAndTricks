# Extract nested JSON from SQLite
This example is based on: [How do I get nested JSON data out of SQLite with a multi-level group by?](https://stackoverflow.com/questions/55421128/how-do-i-get-nested-json-data-out-of-sqlite-with-a-multi-level-group-by)

-- https://stackoverflow.com/a/61004015/7485823
-- tblSmall with json(x)

## Create table
```sql
DROP TABLE IF EXISTS tblSmall;
pragma encoding = 'UTF-8';
CREATE TABLE IF NOT EXISTS tblSmall (
    region      TEXT,
    subregion   TEXT,
    postalcode  TEXT,
    locality    TEXT,
    lat         TEXT,
    lng         TEXT
);
pragma encoding;
```

## Insert data

```sql
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "Central Delhi", "110001", "Parliament House", "28.6407", "77.2154");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "Central Delhi", "110003", "Pandara Road", "28.6431", "77.2197");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "Central Delhi", "110004", "Rashtrapati Bhawan", "28.6453", "77.2128");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "Central Delhi", "110005", "Karol Bagh", "28.6514", "77.1907");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "Central Delhi", "110005", "Anand Parbat", "28.6431", "77.2197");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "North Delhi", "110054", "Civil Lines (North Delhi)", "28.6804", "77.2263");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "North Delhi", "110084", "Burari", "28.7557", "77.1994");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "North Delhi", "110084", "Jagatpur", "28.7414", "77.2199");
REPLACE INTO tblSmall (region, subregion, postalcode, locality, lat,lng) VALUES("Delhi", "North Delhi", "110086", "Kirari Suleman Nagar", "28.7441", "77.0732");
```

## SELECT data

### Get JSON object

```sql
select json_object('region', A2.region, 'subregions', json_group_array(json(A2.json_obj2))) from
  (select A1.region, json_object('subregion', 
                                 A1.subregion, 
                                 'postalCodes', 
                                 json_group_array(json(A1.json_obj1)) ) as json_obj2 from
    (select region, subregion, json_object('postalCode', 
                                           postalcode, 
                                           'localities', 
                                           json_group_array(json_object('locality', 
                                                                        locality, 'latitude', 
                                                                        lat, 'longitude', lng) ) ) as json_obj1
    from tblSmall where subregion in ('Central Delhi', 'North Delhi')
    group by region, subregion, postalcode) as A1
  group by A1.region, A1.subregion) as A2
group by A2.region
```
Result:
```json
[{"json_object('region', A2.region, 'subregions', json_group_array(json(A2.json_obj2)))":"{\"region\":\"Delhi\",\"subregions\":[{\"subregion\":\"Central Delhi\",\"postalCodes\":[{\"postalCode\":\"110001\",\"localities\":[{\"locality\":\"Parliament House\",\"latitude\":\"28.6407\",\"longitude\":\"77.2154\"}]},{\"postalCode\":\"110003\",\"localities\":[{\"locality\":\"Pandara Road\",\"latitude\":\"28.6431\",\"longitude\":\"77.2197\"}]},{\"postalCode\":\"110004\",\"localities\":[{\"locality\":\"Rashtrapati Bhawan\",\"latitude\":\"28.6453\",\"longitude\":\"77.2128\"}]},{\"postalCode\":\"110005\",\"localities\":[{\"locality\":\"Karol Bagh\",\"latitude\":\"28.6514\",\"longitude\":\"77.1907\"},{\"locality\":\"Anand Parbat\",\"latitude\":\"28.6431\",\"longitude\":\"77.2197\"}]}]},{\"subregion\":\"North Delhi\",\"postalCodes\":[{\"postalCode\":\"110054\",\"localities\":[{\"locality\":\"Civil Lines (North Delhi)\",\"latitude\":\"28.6804\",\"longitude\":\"77.2263\"}]},{\"postalCode\":\"110084\",\"localities\":[{\"locality\":\"Burari\",\"latitude\":\"28.7557\",\"longitude\":\"77.1994\"},{\"locality\":\"Jagatpur\",\"latitude\":\"28.7414\",\"longitude\":\"77.2199\"}]},{\"postalCode\":\"110086\",\"localities\":[{\"locality\":\"Kirari Suleman Nagar\",\"latitude\":\"28.7441\",\"longitude\":\"77.0732\"}]}]}]}"}]
```

Unpack the `json_group_array(json(A2.json_obj2)))` as branch and get:

```json
{"region":"Delhi","subregions":[{"subregion":"Central Delhi","postalCodes":[{"postalCode":"110001","localities":[{"locality":"Parliament House","latitude":"28.6407","longitude":"77.2154"}]},{"postalCode":"110003","localities":[{"locality":"Pandara Road","latitude":"28.6431","longitude":"77.2197"}]},{"postalCode":"110004","localities":[{"locality":"Rashtrapati Bhawan","latitude":"28.6453","longitude":"77.2128"}]},{"postalCode":"110005","localities":[{"locality":"Karol Bagh","latitude":"28.6514","longitude":"77.1907"},{"locality":"Anand Parbat","latitude":"28.6431","longitude":"77.2197"}]}]},{"subregion":"North Delhi","postalCodes":[{"postalCode":"110054","localities":[{"locality":"Civil Lines (North Delhi)","latitude":"28.6804","longitude":"77.2263"}]},{"postalCode":"110084","localities":[{"locality":"Burari","latitude":"28.7557","longitude":"77.1994"},{"locality":"Jagatpur","latitude":"28.7414","longitude":"77.2199"}]},{"postalCode":"110086","localities":[{"locality":"Kirari Suleman Nagar","latitude":"28.7441","longitude":"77.0732"}]}]}]}
```

Or pretty printed:

```json
{
    "region": "Delhi",
    "subregions": [
        {
            "subregion": "Central Delhi",
            "postalCodes": [
                {
                    "postalCode": "110001",
                    "localities": [
                        {
                            "locality": "Parliament House",
                            "latitude": "28.6407",
                            "longitude": "77.2154"
                        }
                    ]
                },
                {
                    "postalCode": "110003",
                    "localities": [
                        {
                            "locality": "Pandara Road",
                            "latitude": "28.6431",
                            "longitude": "77.2197"
                        }
                    ]
                },
                {
                    "postalCode": "110004",
                    "localities": [
                        {
                            "locality": "Rashtrapati Bhawan",
                            "latitude": "28.6453",
                            "longitude": "77.2128"
                        }
                    ]
                },
                {
                    "postalCode": "110005",
                    "localities": [
                        {
                            "locality": "Karol Bagh",
                            "latitude": "28.6514",
                            "longitude": "77.1907"
                        },
                        {
                            "locality": "Anand Parbat",
                            "latitude": "28.6431",
                            "longitude": "77.2197"
                        }
                    ]
                }
            ]
        },
        {
            "subregion": "North Delhi",
            "postalCodes": [
                {
                    "postalCode": "110054",
                    "localities": [
                        {
                            "locality": "Civil Lines (North Delhi)",
                            "latitude": "28.6804",
                            "longitude": "77.2263"
                        }
                    ]
                },
                {
                    "postalCode": "110084",
                    "localities": [
                        {
                            "locality": "Burari",
                            "latitude": "28.7557",
                            "longitude": "77.1994"
                        },
                        {
                            "locality": "Jagatpur",
                            "latitude": "28.7414",
                            "longitude": "77.2199"
                        }
                    ]
                },
                {
                    "postalCode": "110086",
                    "localities": [
                        {
                            "locality": "Kirari Suleman Nagar",
                            "latitude": "28.7441",
                            "longitude": "77.0732"
                        }
                    ]
                }
            ]
        }
    ]
}
```
