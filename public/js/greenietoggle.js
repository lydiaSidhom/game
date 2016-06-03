function greenietoggle(){

	x= document.getElementById('map-list').className;
	if(x == "tabs-title is-active"){
		document.getElementById('map-list').className.replace(/\btabs-title is-active\b/, 'tabs-title');
	}
	console.log(document.getElementById('map-list').className);
}