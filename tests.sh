# PUT PATH TO BASH 4.2 BINARY HERE
# Test pforb
. ./cpfb

testKeyValues() {
	local tot=0
	[[ "$Name" ]] || let tot+=1
	[[ "$Main_Use" ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
		passed "Key = Values"
	else
		failed "Key = Values"
	fi
}

testIndexedArrays() {
	local tot=0
	[[ "${MyArray[1]}" =~ ^Some\ otherThing:$ ]] || let tot+=1
	[[ "${#MyArray[@]}" -eq 2 ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
                passed "Indexed arrays"
        else
                failed "Indexed arrays"
        fi
}

testAssociativeArrays() {
	local tot=0
	[[ "${OtherArray[gitgit]}" =~ ^bestThing\;maybe$ ]] || let tot+=1
	[[ "${#OtherArray[@]}" -eq 2 ]] || let tot+=1
	if [[ $tot -eq 0 ]]; then
		passed "Associative arrays"
	else
		failed "Associative arrays"
	fi
}

runTests() {
	parseConfig "$1" || exit 1
	echo "Running KeyValues..."
	testKeyValues "$1"
	echo "Running Arrays..."
	testIndexedArrays "$1"
	testAssociativeArrays "$1"
	echo "Done"
}

failed() {
	echo "--Failed $1"
}

passed() {
	echo "--Passed $1"
}

runTests "./example.conf"
