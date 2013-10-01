<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Convert your Java code to Scala">
<meta name="author" content="Shekhar Gulati">
<title>Java2Scala - Convert your Java code to Scala</title>

<link rel="stylesheet" href="css/codemirror.css">
<script src="js/codemirror.js"></script>
<script src="js/matchbrackets.js"></script>
<script src="js/clike.js"></script>
<link rel="stylesheet" href="css/docs.css">
<style>
.CodeMirror {
	border: 2px inset #dee;
}
</style>

<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.labelStopwatch {
	float: left;
	width: 25em;
	text-align: right;
	padding-right: 10px;
}

#stopwatch {
	margin-bottom: 10px;
	width: 150px;
	border-bottom-left-radius: 4px 4px;
	border-bottom-right-radius: 4px 4px;
	border-top-left-radius: 4px 4px;
	border-top-right-radius: 4px 4px;
	border: 2px solid #EEE;
	float: left;
	padding: 0px 8px;
}
</style>
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/jquery.loadmask.css" rel="stylesheet" type="text/css" />
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.css"
	rel="stylesheet">
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="<c:url value="/" />">Java2Scala</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="active"><a href="<c:url value="/" />">Home</a></li>
					</ul>

				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="span7">
				<h2>Write Java Code</h2>
				<form id="codeForm">
					<div class="control-group">
						<div class="controls">
							<textarea id="code" name="code"
								placeholder="Write Java Code"></textarea>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<button type="submit" class="btn btn-success">Convert To Scala</button>
						</div>
					</div>
				</form>

			</div>


			<div id="outputBox" class="span4 offset1">

				<div id="stopWatchRow" class="row">
					<h2>Program Timer (hh:mm:ss)</h2>
					<div id="stopwatch" class="span4">00:00:00</div>
				</div>

				<div id="resultRow" class="row">
					<h2>Scala Code</h2>
						<textarea id="scalaCode" name="scalaCode"
								placeholder="Scala Code"></textarea>
				</div>

			</div>

		</div>


		<footer id="footer">
			<p>&copy; Shekhar Gulati 2013</p>

			<p>
				Made with love by <a href="https://twitter.com/shekhargulati/"
					target="_blank">Shekhar Gulati</a>. Contact him at <a
					href="mailto:shekhargulati84@gmail.com">shekhargulati84@gmail.com</a>.
			</p>
			<p>
				<a href="https://www.openshift.com/" target="_blank"><img
					alt="Powered by OpenShift"
					src="https://www.openshift.com/sites/default/files/images/powered-transparent-black.png"></a>
			</p>

		</footer>

	</div>

	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="js/jquery.stopwatch.js"></script>


	<script type="text/javascript">
		/* $("#resultRow").hide(); */
	</script>
	<script>
		var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
			lineNumbers : true,
			matchBrackets : true,
			mode : "text/x-java"
		});
		var scalaEditor = CodeMirror.fromTextArea(document.getElementById("scalaCode"), {
			lineNumbers : true,
			matchBrackets : true,
			mode : "text/x-scala"
		});
	</script>

	<script type="text/javascript">
		$("#codeForm")
				.submit(
						function(event) {
							event.preventDefault();
							$('#stopwatch').stopwatch().stopwatch('reset');
							$("#status").empty();
							$("#result").empty();
							var code = $('textarea').val();

							if (!code) {
								alert("Please write some code");
								return;
							}
							$("#codeForm").mask("Running...");
							$('#stopwatch').stopwatch().stopwatch('start');
							var data = {
								code : code
							};
							var url = "http://www.java2scala.in/api/javatoscala";

							$
									.ajax(
											url,
											{
												data : JSON.stringify(data),
												contentType : 'application/json',
												type : 'POST',
												success : function(result) {
													$("#codeForm").unmask();
													$('#stopwatch').stopwatch()
															.stopwatch('stop');
													console.log(result['scalaCode']);
													$("#resultRow").show();
													if('error' in result){
														scalaEditor.setValue(result['error']);
													}else{
														scalaEditor.setValue(result['scalaCode']);	
													}
													
													
													

												},
												error : function(xhr, ajaxOptions, thrownError) {
													console.log(thrownError);
													$("#codeForm").unmask();
													$('#stopwatch').stopwatch()
															.stopwatch('stop');
													alert("Something wrong happened on the server");
												}
											});

						});
	</script>
</body>
</html>