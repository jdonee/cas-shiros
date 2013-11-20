<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String referer = request.getParameter("login-at");
	String separator = (referer.indexOf("?") > -1) ? "&" : "?";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
  <head>
    <script type="text/javascript" language="javascript">
      <!--
      var redirectURL = "<%=referer%>" + "<%=separator%>" + "login_error_msg=" + encodeURIComponent("用户名或密码错误");
      window.location.replace(redirectURL);
      -->
    </script>
    <title>Redirect</title>
  </head>
  <body>
  
  </body>
</html>