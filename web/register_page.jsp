

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <main class="primary-background  banner-background" style="padding-bottom: 10px;">
            <div class="container ">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-circle-o fa-3x"></span>
                            <br>
                            Register Here
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="POST">
                                <div class="mb-3">
                                    <label for="user_name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter User NAme">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Email">
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Enter Password">
                                </div>
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Select Gender</label>
                                    <br>
                                    <input type="radio" id="gender" name="gender" value="male"> male
                                    <input type="radio" id="gender" name="gender" value="female"> Female
                                </div>
                                <div class="mb-3" >
                                    <textarea  class="form-control" name="about"  cid="" cols="5" rows="5 " placeholder="Enter Somthing about Your self"></textarea>
                                </div>

                                <div class="mb-3 form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms And Condition</label>
                                </div>
                                <br>
                                <div class="container text-center" id="loader" style="display: none">
                                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                                    <h4>please wait...</h4>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>  
            </div>
        </main>


        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
        <script>
            $(document).ready(function () {
                console.log("loaded..........!")

                $('#reg-form').on('submit', function (event) {

                    event.preventDefault();

                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();


                    //send register servelet
                    $.ajax({

                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);

                            $("#submit-btn").show();
                            $("#loader").hide();
                            
                            if(data.trim()==='done'){
                            swal("Register succsessfuly..We are going to redirect to login page.....")
                                    .then((value) => {
                                        window.location = "login.jsp"
                                    });

                                 }else{
                                     swal(data);
                                 }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                           
                            $("#submit-btn").show();
                            $("#loader").hide();
                            
                            swal("something went wromg try agin.....");


                        },

                        processData: false,
                        contentType: false




                    });

                });
            });
        </script>

    </body>
</html>
