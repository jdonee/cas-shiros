<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<h1>user/index</h1>
<a href="http://localhost:8080/cas/logout?service=http://localhost:8082/app-admin">logout</a><br />
<br />
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%
	Subject subject = SecurityUtils.getSubject();
%>
principal : <%=subject.getPrincipal()%><br />
principals : <%=subject.getPrincipals()%><br />
isAuthenticated : <%=subject.isAuthenticated()%><br />
isRemembered : <%=subject.isRemembered()%><br />