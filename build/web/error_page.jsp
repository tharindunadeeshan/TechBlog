
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry something went wrong...!</title>
        
         <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/styles.css" rel="stylesheet" type="text/css"/>
        <style>
            .banner-background{
              clip-path: polygon(33% 0, 70% 0%, 100% 0, 100% 100%, 70% 99%, 30% 100%, 0 94%, 0 0);
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/system.png" class="img-fluid">
            <h3 class="display-3">Sorry something went wrong....!</h3>
            <%= exception %>
            <a href="index.jsp" class="btn primary-background btn-lg text-white">Home</a>
            
        </div>
        
    </body>
</html>
