# PUT PATH TO BASH 4.2 BINARY HERE
# Test pforb
. "./cpfb"

testKeyValues() {
	local tot=0
	parseConfig "$1" || let tot+=1
	[[ "$Main_Name" ]] || let tot+=1
	[[ "$Main_Use" ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
		passed "Key = Values"
	else
		failed "Key = Values"
	fi
}

testIndexedArrays() {
	local tot=0
	parseConfig "$1" || let tot+=1
	[[ "${MyArray[0]}" ]] || let tot+=1
	[[ "${#MyArray[@]}" -eq 2 ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
                passed "Indexed arrays"
        else
                failed "Indexed arrays"
        fi
}

testAssociativeArrays() {
	local tot=0
	parseConfig "$1" || let tot+=1
	[[ "${OtherArray[index]}" ]] || let tot+=1
	[[ "${#OtherArray[@]}" -eq 2 ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
		passed "Associative arrays"
	else
		failed "Associative arrays"
	fi
}

runTests() {
	echo "Running KeyValues..."
	testKeyValues "$1"
	echo "Running Arrays..."
	testIndexedArrays "$1"
	testAssociativeArrays "$1"
	echo "Done"
}

failed() {
	echo "Failed $1"
}

passed() {
	echo "Passed $1"
}

runTests "$1"
