## Pass associative array by reference

Source: [@@stackoverflow-icon@@](https://stackoverflow.com/a/71060913)

```bash
# Print an associative array by passing the array by reference
# Usage:
#       # General form:
#       print_associative_array2 array
#       # Example
#       print_associative_array2 array1
print_associative_array2() {
    # declare a local **reference variable** (hence `-n`) named `array_reference`
    # which is a reference to the value stored in the first parameter
    # passed in
    local -n array_reference="$1"

    # print the array by iterating through all of the keys now
    for key in "${!array_reference[@]}"; do
        value="${array_reference["$key"]}"
        echo "  $key: $value"
    done
}

# Let's create and load up an associative array and print it
declare -A array1
array1["a"]="cat"
array1["b"]="dog"
array1["c"]="mouse"


echo 'print_associative_array2 array1'
print_associative_array2 array1
echo ""
echo "OR (same thing--quotes don't matter in this case):"
echo 'print_associative_array2 "array1"'
print_associative_array2 "array1"
```
