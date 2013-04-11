<%@ page import="com.netflix.zuul.scriptManager.FilterInfo" %>
<%@ page import="com.netflix.zuul.scriptManager.ZuulFilterDAO" %>
<%@ page import="com.netflix.zuul.scriptManager.ZuulFilterDAOCassandra" %>
<%@ page import="com.netflix.zuul.util.AdminFilterUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.netflix.zuul.StartServer" %>
<%--
  Created by IntelliJ IDEA.
  User: mcohen
  Date: 6/18/12
  Time: 11:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ZuulFilterDAO scriptDAO = null;
    try {
        scriptDAO = new ZuulFilterDAOCassandra(StartServer.getZuulCassContext());
    } catch (Exception e) {
        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
    }
    List<String> filterIds = scriptDAO.getAllFilterIDs();
%>
<html>
<head>
    <title></title>
</head>
<body>

UPLOAD
<form method="POST" enctype="multipart/form-data" action="scriptmanager?action=UPLOAD">
    <input type="file" name="upload" size="40"/>
    <input type="submit"/>
</form>

<br>
ACTIVE SCRIPTS
<table border="1">
    <tr>
        <td>NAME</td>
        <td>TYPE</td>
        <td>ORDER</td>
        <td>DISABLE PROPERTY</td>
        <td>CREATE DATE</td>
        <td>REVISION</td>
        <td>STATE</td>
    </tr>
    <%

        List<FilterInfo> filters = scriptDAO.getAllActiveScripts();
        for (FilterInfo filter : filters) {
    %>
    <tr>
        <td><%=filter.getFilterName()%>
        </td>
        <td><%=filter.getFilterType()%>
        </td>
        <td><%=filter.getFilterOrder()%>
        </td>
        <td><%=filter.getFilterDisablePropertyName()%>
        </td>
        <td><%=filter.getCreationDate()%>
        </td>
        <td><%=filter.getRevision()%>
        </td>
        <td><%=AdminFilterUtil.getState(filter)%>
        </td>
        <td><%=AdminFilterUtil.buildDeactivateForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildDownloadLink(filter.getFilterID(), filter.getRevision())%>
        </td>
    </tr>
    <%
        }
    %>
</table>


<br>
CANARY SCRIPTS
<table border="1">
    <tr>
        <td>NAME</td>
        <td>TYPE</td>
        <td>ORDER</td>
        <td>DISABLE PROPERTY</td>
        <td>CREATE DATE</td>
        <td>REVISION</td>
        <td>STATE</td>
    </tr>
    <%

        filters = scriptDAO.getAllCanaryScripts();
        for (FilterInfo filter : filters) {
    %>
    <tr>
        <td><%=filter.getFilterName()%>
        </td>
        <td><%=filter.getFilterType()%>
        </td>
        <td><%=filter.getFilterOrder()%>
        </td>
        <td><%=filter.getFilterDisablePropertyName()%>
        </td>
        <td><%=filter.getCreationDate()%>
        </td>
        <td><%=filter.getRevision()%>
        </td>
        <td><%=AdminFilterUtil.getState(filter)%>
        </td>
        <td><%=AdminFilterUtil.buildDeactivateForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildActivateForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildDownloadLink(filter.getFilterID(), filter.getRevision())%>
        </td>
    </tr>
    <%
        }
    %>
</table>

<br>
LATEST SCRIPTS
<table border="1">
    <tr>
        <td>NAME</td>
        <td>TYPE</td>
        <td>ORDER</td>
        <td>DISABLE PROPERTY</td>
        <td>CREATE DATE</td>
        <td>REVISION</td>
        <td>STATE</td>
        <td>Activate</td>
        <td>Make Canary</td>

    </tr>
    <%

        for (String filterID : filterIds) {
            FilterInfo filter = scriptDAO.getLatestScriptForFilter(filterID);
    %>
    <tr>
        <td><%=filter.getFilterName()%>
        </td>
        <td><%=filter.getFilterType()%>
        </td>
        <td><%=filter.getFilterOrder()%>
        </td>
        <td><%=filter.getFilterDisablePropertyName()%>
        </td>
        <td><%=filter.getCreationDate()%>
        </td>
        <td><%=filter.getRevision()%>
        </td>
        <td><%=AdminFilterUtil.getState(filter)%>
        </td>
        <td><%=AdminFilterUtil.buildActivateForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildCanaryForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildDownloadLink(filter.getFilterID(), filter.getRevision())%>
        </td>
    </tr>
    <%
        }
    %>
</table>


<br>
All SCRIPTS
<table border="1">
    <tr>
        <td>NAME</td>
        <td>TYPE</td>
        <td>ORDER</td>
        <td>DISABLE PROPERTY</td>
        <td>CREATE DATE</td>
        <td>REVISION</td>
        <td>STATE</td>
        <td>Activate</td>
        <td>Make Canary</td>
    </tr>
    <%

        for (String filterID : filterIds) {
            filters = scriptDAO.getScriptsForFilter(filterID);
            for (FilterInfo filter : filters) {
    %>
    <tr>
        <td><%=filter.getFilterName()%>
        </td>
        <td><%=filter.getFilterType()%>
        </td>
        <td><%=filter.getFilterOrder()%>
        </td>
        <td><%=filter.getFilterDisablePropertyName()%>
        </td>
        <td><%=filter.getCreationDate()%>
        </td>
        <td><%=filter.getRevision()%>
        </td>
        <td><%=AdminFilterUtil.getState(filter)%>
        </td>
        <td><%=AdminFilterUtil.buildActivateForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildCanaryForm(filter.getFilterID(), filter.getRevision())%>
        </td>
        <td><%=AdminFilterUtil.buildDownloadLink(filter.getFilterID(), filter.getRevision())%>
        </td>
    </tr>
    <%
            }
        }
    %>

</table>

</body>
</html>