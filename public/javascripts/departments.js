var departments = new Array();
<% for department in @departments -%>
	departments.push(new Array(<%= department.faculty_id%>,'<%=h department.name%>',<%= department.id%>));
<% end -%>


function facultySelected() {	
	options = $('faculty_id').children[0].options;
	options = $('department_id').children[0].options;
	//options.length = 1 
	departments.each(function(department){
  	if (department[0] == faculty_id){
  		options[options.length] = new Option(department[1],department[2]);
  	}
  });
	
	alert(options[0].text + ' ' +options[0].value)   
 
  options.length = 1;
  departments.each(function(department){
  	if (department[0] == faculty_id){
  		options[options.length] = new Option(department[1],department[2]);
  	}
  });
  if (options.length ==1){
  	$('departments').hide();
  	else
  	$('departments').show();
  }  
}



document.observe('dom:loaded', function() {
  //$('departments').hide();  
  $('faculty_id').observe('change', facultySelected);
});
