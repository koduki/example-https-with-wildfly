<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>http2のテストページ</title>
        <meta charset="utf-8">
    </head> 
    <body>
        <%
            long current = System.nanoTime();
            for (int i = 0; i < 500; i++) {
        %>
        <!-- キャッシュさせないために、パラメータをつけておく -->
        <img src="wildfly_logomark_64px.png?<%=current + i%>" />
        <%
            }
        %>
    </body>
</html>