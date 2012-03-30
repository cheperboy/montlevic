function toggleCat(cat) {
//	var motifok = /level-[0-9](_[A-Za-z0-9-]*(agri.service))/;
//	var motifok1 = /level-[0-9](_(agri.batiment)[A-Za-z0-9.-]+)/; //que les sous cats
	
	//var motif0 = '/level:[0-9](_code:[A-Za-z0-9-]*('+ cat +'))/';
	// var motif1 = Regexp.new('^mat');
	//var motif1 = /(mytest)/;
		
	// var motif2 = /[A-Za-z0-9._-]*(agri)[A-Za-z0-9_.-]*/;
	// var motif = /[A-Za-z0-9._-]*/;
	// var motiftest = "/level-[0-9](_(agri.batiment)[A-Za-z0-9.-]+)/";

	// var motiforig = '/level-[0-9](_('+ cat +')[A-Za-z0-9.-]+)/'; //que les sous cats de "level-x_cat.subcat"
	var motif = 'level-[0-9](_('+ cat +')[A-Za-z0-9.-]+)'; //que les sous cats de "level-x_cat.subcat"
	var reg = RegExp(motif);
	var els = document.getElementsByTagName("tr");
  var i;
	var show = 'yes'
	// if (this.name == 'hide') { 
	if (this.style.display == 'block') { 
		show = 'no';
		this.name = 'show';
	}
	else {
		show = 'yes';
		this.name = 'hide';
	}
	
	for (i = 0; i < els.length; i += 1) {
		if ((show == 'yes') && (reg.test(els[i].className))) {
			els[i].style.display = ''; 
		} 
		if ((show == 'no') && (reg.test(els[i].className))) {
			// alert('no '+els[i].className+' motif:'+motif);
			els[i].style.display = 'none';
		}
	}
}



function toggleLevel_by_name(name) {
    var els = document.getElementsByClassName(name);
    var i;
    for (i = 0; i < els.length; i += 1) {
		if (els[i].style.display == '')  els[i].style.display = 'none';
		else els[i].style.display = '';
	}
}

function toggleLevel4(name) {
    var els = document.getElementsByClassName(name);
    var i;
    for (i = 0; i < els.length; i += 1) {
		if (els[i].style.display == '')  els[i].style.display = 'none';
		else els[i].style.display = '';
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
		if ((show == 'no') && ((els[i].className.split('_')[0] == 'level-2') || (els[i].className.split('_')[0] == 'level-3') || (els[i].className.split('_')[0] == 'level-4'))) {
			els[i].style.display = 'none';
		}
	}
}

function toggleAllLevel3() {
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
		if ((show == 'yes') && ((els[i].className.split('_')[0] == 'level-3') || (els[i].className.split('_')[0] == 'level-4'))) {
			els[i].style.display = ''; 
		} 
		if ((show == 'no') && ((els[i].className.split('_')[0] == 'level-3') || (els[i].className.split('_')[0] == 'level-4'))) {
			els[i].style.display = 'none';
		}
	}
}

function toggleLevel2(factcatCode) {
	var els = document.getElementsByTagName("tr");
  var i;
	if (this.name == 'btn-hide') {
	    for (i = 0; i < els.length; i += 1) {
		    if ((els[i].className == 'level-2_'+factcatCode) || (els[i].className.split('.')[0] == 'level-3_'+factcatCode) || (els[i].className.split('.')[0] == 'level-4_'+factcatCode)) {
				els[i].style.display = 'none';
			}
		}
		this.name = 'btn-show';
	}
	else {
	    for (i = 0; i < els.length; i += 1) {
		    if ((els[i].className == 'level-2_'+factcatCode) || (els[i].className.split('.')[0] == 'level-3_'+factcatCode)) {
				els[i].style.display = '';
			}
		}
		this.name = 'btn-hide';
	}
}
function toggleLevel3(factcatCode) { 

	// factcatCode = agri.produits_used
	// level-3_agri.produits_used
	// level-4_agri.produits_used.engrais

	var els = document.getElementsByTagName("tr");
  var i;
	if (this.name == 'btn-hide') {
		for (i = 0; i < els.length; i += 1) {
			var var1 = els[i].className.split('.')[0] + '.' + els[i].className.split('.')[1] // var1 = level-4_agri.produits_used
			// var var2 = var1.split('_')[1] // var2 = agri.produits_used
			
			if ((els[i].className == ('level-3_'+factcatCode)) || (var1 == 'level-4_'+factcatCode) || (els[i].className.split('.')[0] == 'level-4_'+factcatCode)) {
				// alert('msg ' + 'level-3_'+factcatCode);
				els[i].style.display = 'none';
			}
		}
		this.name = 'btn-show';
	}
	else {
	    for (i = 0; i < els.length; i += 1) {
				var var1 = els[i].className.split('.')[0] + '.' + els[i].className.split('.')[1] // var1 = level-4_agri.produits_used
		    if ((els[i].className == 'level-3_'+factcatCode) || (els[i].className.split('.')[0] == ('level-3_'+factcatCode)) || (var1 == 'level-4_'+factcatCode)) {
				els[i].style.display = '';
			}
		}
		this.name = 'btn-hide';
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


