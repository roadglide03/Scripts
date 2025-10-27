function ClusterTest(){
try {
	run ('cd /');
	run ('configuration cluster');
	return(true);
	}
catch (err) {
	if (err=EAKSH_BADCMD) {
		return(false);
	}
	else {			//catch unknown condition
		throw("Unexpected cluster test error");	
		}
	}
}
//Main start
printf("Checking if node is part of a cluster; ");
if ( ClusterTest() )
	printf("Yes we are good!\n");
else
	printf("No not part of a cluster\n");
