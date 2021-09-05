//go:build rpctest
// +build rpctest

package itest

var allTestCases = []*testCase{
	{
		name: "double spend funding tx fail funding flow",
		test: testChannelForceClosure,
	},
}
