## Wrap commands with comments


(Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/1456019))


This will have some overhead, but technically it does answer your question:
```shell
echo abc `#Put your comment here` \
     def `#Another chance for a comment` \
     xyz, etc.
```
And for pipelines specifically, there is a clean solution with no overhead:
```shell
echo abc |        # Normal comment OK here
     tr a-z A-Z | # Another normal comment OK here
     sort |       # The pipelines are automatically continued
     uniq         # Final comment
```
And the same with redirect to file:

```shell
(
echo abc |        # Normal comment OK here
     tr a-z A-Z | # Another normal comment OK here
     sort |       # The pipelines are automatically continued
     uniq         # Final comment
) > file
```
