function toggleCat(cat) {
	console.log('cat='+ cat);
	// var motif = 'level-[0-9](_('+ cat +')[A-Za-z0-9.-]+)'; //que les sous cats de "level-x_cat.subcat"
	var motif = 'level-[0-9](_('+ cat +').[A-Za-z0-9]+)'; //que les sous cats de "level-x_cat.subcat"
	var regex = RegExp(motif);
	var motifA = '('+ cat +').[A-Za-z0-9]+'; 							//tout les liens tels que "cat.'subcat'.'subsubcat'"
	var regexA = RegExp(motifA);
	// var motif = 'level-[0-9](_('+ cat +').(\w+))'; //que les sous cats de "level-x_cat.subcat"
	var trs = 	document.getElementsByTagName("tr");
	var links = document.getElementsByTagName("a");
	var link = 	document.getElementsByName(cat);
	link = link[0];
  var i;
	var display = ''

	// cette boucle permet d'identifier 'link'.
	// devrait etre remplacer par la fonct adequat : getElementByName 
	// for (i = 0; i < links.length; i += 1) {
	// 	if (links[i].name == cat) {
	// 		link = links[i];
	// 	}
	// }		
	
	console.log('\tlink: '+ link.name+'='+ link.className);
	
	if (link.className != 'hidden') { 
		console.log('\tlink.className != hidden');
		display = 'no';
		link.className = 'hidden';
		// repositionne correctement les class des liens:
		// Tous les lien qui sont sous le lien cliqué (correspondants aux subcats)
		// on leur className repositionnée a hidden ou visible suivant le cas
		// INUTIL
		console.log('\tsub liens:');
		for (i = 0; i < links.length; i += 1) {
			if (regexA.test(links[i].name)) {
				links[i].className = 'hidden';
				console.log('\t\tA->hidden '+ links[i].name+'='+links[i].className);
			}
		}		
	}
	else {
		display = 'yes';
		link.className = 'visible';
		// repositionne correctement les class des liens:
		console.log('\tsub liens:');
		for (i = 0; i < links.length; i += 1) {
			if (regexA.test(links[i].name)) {
				links[i].className = 'visible';
				console.log('\t\tA->visible '+ links[i].name+'='+links[i].className);
			}
		}		
	}
	for (i = 0; i < trs.length; i += 1) {
		if ((display == 'yes') && (regex.test(trs[i].className))) {
			trs[i].style.display = '';
			// console.log('trs['+i+'].style = '+trs[i].style);
			// console.log('trs['+i+'].style.display = '+trs[i].style.display);
		} 
		if ((display == 'no') && (regex.test(trs[i].className))) {
			trs[i].style.display = 'none';
			// console.log('trs['+i+'].style = '+trs[i].style);
			// console.log('trs['+i+'].style.display = '+trs[i].style.display);
		}
	}
	// console.log('link.name='+ this.name);
	console.log('\tFIN: link.className='+ link.className);
	console.log('');
}

function toggleCattest(cat) {
	console.log('this='+ this);
	// var motif = 'level-[0-9](_('+ cat +')[A-Za-z0-9.-]+)'; //que les sous cats de "level-x_cat.subcat"
	var motif = 'level-[0-9](_('+ cat +').[A-Za-z0-9]+)'; //que les sous cats de "level-x_cat.subcat"
	// var motif = 'level-[0-9](_('+ cat +').(\w+))'; //que les sous cats de "level-x_cat.subcat"
	var reg = RegExp(motif);
	var trs = document.getElementsByTagName("tr");
  var i;
	var display = ''
	
	console.log('this.name='+ this.name);
	
	if (this.name != 'hidden') { 
		display = 'no';
		this.name = 'hidden';
	}
	else {
		console.log('this.name == hidden');
		display = 'yes';
		this.name = 'visible';
	}	
	for (i = 0; i < trs.length; i += 1) {
		if ((display == 'yes') && (reg.test(trs[i].className))) {
			trs[i].style.display = ''; 
			console.log('trs['+i+'].style = '+trs[i].style);
			console.log('trs['+i+'].style.display = '+trs[i].style.display);
		} 
		if ((display == 'no') && (reg.test(trs[i].className))) {
			trs[i].style.display = 'none';
			console.log('trs['+i+'].style = '+trs[i].style);
			console.log('trs['+i+'].style.display = '+trs[i].style.display);
		}
	}
	console.log('this.name='+ this.name);
	console.log('');
}

function toggleCatOld(cat) {
	// var motif = 'level-[0-9](_('+ cat +')[A-Za-z0-9.-]+)'; //que les sous cats de "level-x_cat.subcat"
	var motif = 'level-[0-9](_('+ cat +').[A-Za-z0-9]+)'; //que les sous cats de "level-x_cat.subcat"
	// var motif = 'level-[0-9](_('+ cat +').(\w+))'; //que les sous cats de "level-x_cat.subcat"
	var reg = RegExp(motif);
	var els = document.getElementsByTagName("tr");
  var i;
	var show = 'yes'
	
		// console.log("this.style.undefined: "+(this.style == undefined));
	if (this.name != 'show') { 
		show = 'no';
		this.name = 'show';
	}
	else {
		show = 'yes';
		this.name = 'hide';
	}	
	for (i = 0; i < els.length; i += 1) {
		if ((show == 'yes') && (reg.test(els[i].className))) {
			// console.log("show=yes");
			els[i].style.display = ''; 
		} 
		if ((show == 'no') && (reg.test(els[i].className))) {
			els[i].style.display = 'none';
			// console.log("show=no, style put to none (defined)");
			// console.log("this.style.undefined?: "+(this.style == undefined));
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


