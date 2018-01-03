<!DOCTYPE html>
<html>
	<head>
		<title>Coldfusion Trainning</title>

		<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
		<script type="text/javascript" src="jquery-3.2.1.js"></script> 
		<script src='pagination.js'></script>
		<script type="text/javascript" src="jquery.tablesorter.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>

		<style>
			.table-hover tbody tr:hover > td,
			.table-hover tbody tr:hover > th {
			  background-color: #a4a6ad; 
			}
	
			.page-navigation a {
  			  margin: 0 2px;
			  display: inline-block;
			  padding: 3px 5px;
			  color: #ffffff;
			  background-color: #70b7ec;
			  border-radius: 5px;
			  text-decoration: none;
			  font-weight: bold;
			}

			.page-navigation a[data-selected] {
  			  background-color: #3d9be0;
			}

			.table th{
				font-size: 12px;
				background-color: #70b7ec;
				color: #FFFFFF;
				font-family: “Trebuchet MS”, Verdana;
				padding: 5px;
				border-right-width: 1px;
				border-bottom-width: 1px;
				border-right-style: solid;
				border-bottom-style: solid;
				text-transform: uppercase;
			}

			th.header { 
			    background-image: url("images/bg.gif"); 
			    cursor: pointer; 
			    font-weight: bold; 
			    background-repeat: no-repeat; 
			    background-position: center left; 
			    padding-left: 20px; 
			    border-right: 1px solid #dad9c7; 
			    margin-left: -1px; 
			} 

			th.headerSortUp { 
    			background-image: url("images/asc.gif"); 
    			background-color: #6495ED; 
			} 

			th.headerSortDown { 
			    background-image: url("images/desc.gif"); 
			    background-color: #6495ED; 
			} 

		</style>


		<cfquery name="MoviesQry" datasource="cc">
			SELECT *
			  FROM movies
		</cfquery> 
		
	</head>

	<body>

		<cfoutput>
			<div class="span12">
				<h1 align="center">Display Data from Movies Table</h1>	
				<table id="my-table" class="table table-bordered table-hover">
					<thead>
						<tr >
							<th>Row</th>		
							<th>Id</th>		
							<th>Title</th>		
							<th>Release Date</th>
							<th>Vote Count</th>
						</tr>
					</thead>
					<tbody id="movie-tbodymovie-tbody">
						<cfloop query="MoviesQry">
								<tr>
									<td>#MoviesQry.currentRow#</td>	
									<td>#MoviesQry.id#</td>			
									<td>#MoviesQry.title#</td>		
									<td>#dateformat(MoviesQry.release_date,"short")#</td>		
									<td>#MoviesQry.vote_count#</td>		
								</tr>
						</cfloop>
					</tbody>
				</table>
			</div>	
		</cfoutput>

		<div class="col-md-12 text-center">
			  <ul class="pagination" id="pager"></ul>
		</div>

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">The Movie Detail</h4>
					</div>
					<div class="modal-body">
						<cfoutput>
							<div class="container-fluid">		
							<table class="table table-bordered">
								<thead >
									<tr>
										<th>Image</th>
										<th>Popularity</th>
										<th>Overview</th>		
									</tr>
								</thead>
								<tbody id="my-body"> 			
								</tbody>
							</table>
							</div>	
						</cfoutput>		
					</div>
				</div>
			</div>
		</div>
		<script>
			
			$(document).ready(function() {
				$("table").tablesorter();

				$('#my-table').paginate({ 
				  limit: 20, // 10 elements per page
				  initialPage: 1, // Start on second page
				  previous: false, // Show previous button
				  previousText: 'Prev', // Change previous button text
				  next: false, // Show previous button
				  nextText: 'Next', // Change next button text
				  first: true, // Show first button
				  firstText: '«', // Change first button text
				  last: true, // Show last button
				  lastText: '»', // Change last button text
				  optional: true // Always show the navigation menu
				});

				$("tr").click(function () {
					// get rows
					var rowstbl =  $(this).find("td");
					// get id movie

					var idmovie = $($(rowstbl).get(1)).text();
					var $result = $("#my-body");

		            $.ajax({
		            	url: "http://projects.local/moviesdb/detailquery.cfm", 
		            	method: "GET", 
		            	data: {id: idmovie}, 
		            	success: function(resp) {
		            		//$("#my-body").append(resp);
		            		//$(resp).appendTo("#my-body");
		            		$result.html(resp);
		            	},
		            	error: function(a, b, c) {
		            		console.log(a,b,c);
		            	}
		        	});
		 
		        	$('#myModal').fadeIn("slow").modal({show:true});
				});		
			});	
		</script> 
	</body>
</html>

