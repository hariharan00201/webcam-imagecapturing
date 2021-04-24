<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">

.wrapper{
	display: grid;
	grid-template-columns:repeat(2,1fr);
	grid-gap:5px;
}

.wrapper1{
	display: grid;
	grid-template-columns:repeat(2,1fr);
	grid-gap:5px;
}

video,canvas {
	width:400px;
	height: 400px;
	background-color: #278;
}

</style>
</head>
<body>

<div class="wrapper">

<div>

<h3>Steps:</h3>
1)Enter your register number.<br>
2)Press start to switch on the webcam and wait till you see your video on the left half.<br>
3)Press capture to snap and wait till your image appears on the right half.<br>
4)Press upload to send the pic.<br>
5)Repeat the process till the counter on your right top reaches 10.
</div>

<div><h1>${count}</h1></div>

</div>

<br><br>
<c:choose>


<c:when test="${count >= 1}">  
	<input type="text" id="regg" required="required" disabled="disabled" value="${regno }"><br><br>
</c:when>  

<c:otherwise>  
	<input type="text" id="regg" required="required" placeholder="Enter RegNo"><br><br>
</c:otherwise>  


</c:choose>

<div class="wrapper1">

<div><video id="webcam" autoplay playsinline width="640" height="480"></video></div>

<div><canvas id="canvas" class="d-none"></canvas></div>

<div><audio id="snapSound" src="audio/snap.wav" preload = "auto"></audio></div>

</div>
<br>
<button onclick="start();"> start </button>  <br><br>
<button onclick="capture();"> capture </button>  <br><br>


<form action="upload" method="post">
<input type="hidden" name="imgg" id="result">
<input type="hidden" name="regno" id="reg">
<input type="submit" value="upload">
</form>

<script
		src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<script
		src='https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.js'></script>
	<script
		src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>

<script type="text/javascript" src="https://unpkg.com/webcam-easy/dist/webcam-easy.min.js"></script>

<script >

const webcamElement = document.getElementById('webcam');
const canvasElement = document.getElementById('canvas');
const snapSoundElement = document.getElementById('snapSound');
const webcam = new Webcam(webcamElement, 'user', canvasElement, snapSoundElement);

function start(){

webcam.start()
   .then(result =>{
      console.log("webcam started");
   })
   .catch(err => {
       console.log(err);
   });


}

function capture(){

var picture = webcam.snap();
console.log(picture);
var decodeAsString=atob(picture.split(',')[1]);
		
		var arr=[];
		for(var i=0;i<decodeAsString.length;i++)
		{
			arr.push(decodeAsString.charCodeAt(i));
		}
		
		var temp=new Blob([new Uint8Array(arr)],{
			type:'image/png'
		});
		
		var reader = new FileReader();
 var base64data;
 reader.readAsDataURL(temp); 
 reader.onloadend = function() {
      base64data = reader.result;                
      console.log(base64data.length);
      document.getElementById("result").value = base64data;
      document.getElementById("reg").value =document.getElementById("regg").value;
  }


}

</script>
</body>
</html>