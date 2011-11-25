function toggleLevel3(name) {
    var els = document.getElementsByClassName(name);
    var i;
    for (i = 0; i < els.length; i += 1) {
		if (els[i].style.display == '')  els[i].style.display = 'none';
		else els[i].style.display = '';
	}
}

function toggleAllLevel3() {
	var els = document.getElementsByTagName("tr");
    var i;
	var show = 'yes'
	if (this.name == 'hide') show = 'no';

    for (i = 0; i < els.length; i += 1) {
		if (show == 'yes') {
	    	if ((els[i].className.split('_')[0] == 'level-3') || (els[i].className.split('_')[0] == 'level-2')) {
				els[i].style.display = ''; 
			} 
		}
		else {
	    	if ((els[i].className.split('_')[0] == 'level-3')) {
				els[i].style.display = 'none';
			}
		}
	}
	if (this.name == 'show') {
		this.name = 'hide';
	}
	else {
		this.name = 'show';
	}
}

function toggleAllLevel2() {
	var els = document.getElementsByTagName("tr");
    var i;
	var show = 'yes'
	if (this.name == 'hide') { 
		show = 'no';
		this.name = 'show';
	}
	else {
		show = 'yes';
		this.name = 'hide';
	}
	
    for (i = 0; i < els.length; i += 1) {
	    if ((show == 'yes') && ((els[i].className.split('_')[0] == 'level-2') || (els[i].className.split('_')[0] == 'level-3'))) {
			els[i].style.display = ''; 
		} 
		if ((show == 'no') && ((els[i].className.split('_')[0] == 'level-2') || (els[i].className.split('_')[0] == 'level-3'))) {
			els[i].style.display = 'none';
		}
	}
}

function toggleLevel2(factcatCode) {
	var els = document.getElementsByTagName("tr");
    var i;
	if (this.className == 'btn-hide') {
	    for (i = 0; i < els.length; i += 1) {
		    if ((els[i].className == 'level-2_'+factcatCode) || (els[i].className.split('.')[0] == 'level-3_'+factcatCode)) {
				els[i].style.display = 'none';
			}
		}
		this.className = 'btn-show';
	}
	else {
	    for (i = 0; i < els.length; i += 1) {
		    if ((els[i].className == 'level-2_'+factcatCode) || (els[i].className.split('.')[0] == 'level-3_'+factcatCode)) {
				els[i].style.display = '';
			}
		}
		this.className = 'btn-hide';
	}
}

function toggleAll(name) {
    var els = document.getElementsByTagName('tr');
    var i;
    for (i = 0; i < els.length; i += 1) 
		{
			if (els[i].style.display == '')  els[i].style.display = 'none';
			else els[i].style.display = '';				
		}
	}


