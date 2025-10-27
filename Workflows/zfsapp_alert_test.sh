// File: Example 6
// Example 5 adapted for alert usage
var MyWorkflow = {

	MyVersion: '1.0',
	MyName: 'Example 6', 
	MyDescription: 'Example of use of Alert', 
	Origin: 'Oracle'
};
var workflow = {
	name: MyWorkflow.MyName, 
	description: MyWorkflow.MyDescription, 
	version: MyWorkflow.MyVersion, 
	alert: true,
	setid: true,
	origin: MyWorkflow.Origin, 
	execute: function (MyAlert) {
// Workflow triggered by alert
		audit('workflow started for alert'+MyAlert.uuid);
 }
};
