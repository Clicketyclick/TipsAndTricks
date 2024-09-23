## Pass associative array by reference

Source: [@@stackoverflow-icon@@](https://stackoverflow.com/a/71060913)

```bash
# Print an associative array by passing the array by reference
# Usage:
#       # General form:
#       print_associative_array2 array
#       # Example
#       print_associative_array2 array1
#print_associative_array2() {
list_items()
    # declare a local **reference variable** (hence `-n`) named `array_reference`
    # which is a reference to the value stored in the first parameter
    # passed in
    local -n array_reference="$1"

    # print the array by iterating through all of the keys now
    for key in "${!array_reference[@]}"; do
        value="${array_reference["$key"]}"
        echo "  $key: $value"
    done
}    # list_items()


# Function to add a task to the array
add_item() {
  local -n array_reference="$1"
  array_reference[${2}]="${3}"
}    # add_item()

# Function to remove a task by index
remove_item() {
  local -n array_reference="$1"
  echo "Item removing: ${2} = ${array_reference[${2}]}"
  unset array_reference[${2}]
}   # remove_item()

# Let's create and load up an associative array and print it
declare -A array1
array1["a"]="cat"
array1["b"]="dog"
array1["c"]="mouse"

list_items array1
# list_items "array1"

add_item "array1" key1 value2
list_items "array1"

remove_item "array1" key1
list_items "array1"
```
