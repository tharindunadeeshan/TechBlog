
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/styles.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(33% 0, 70% 0%, 100% 0, 100% 100%, 70% 99%, 30% 100%, 0 94%, 0 0);
            }
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>

        <!-- Navbar start-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background ">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp" ><span class="fa fa-asterisk" ></span>Tech Blog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#"><span class="fa fa-bell-o"></span> LearnCode With Nadeeshan</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="fa fa-check-square-o"></span>   Categories
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Programming Language</a></li>
                                <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Data Structure</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#add-post-modal"><span class="fa fa-asterisk"></span> Do Post</a>
                        </li>

                    </ul> 
                    <ul class="navbar-nav mr-right ">
                        <li class="nav-item">
                            <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> LogOut</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <!-- navbar end----->

        <%
            Message m = (Message) session.getAttribute("msg");

            if (m != null) {

        %>
        <div class="alert alert-primary" role="alert">
            <%= m.getContent()%>
        </div>
        <%      session.removeAttribute("msg");
            }


        %>
        <!-- start main  body of the page--->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!-- first col----->
                    <div class="col-md-4">
                        <!--categories----->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
                                All posts
                            </a>
                            <!--categories----->
                            <%                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();
                                for (Category cc : list1) {
                            %>
                            <a href="#" onclick="getPosts(<%= cc.getCid() %>,this)" class="c-link list-group-item list-group-item-action"><%= cc.getName()%> </a>

                            <%
                                }
                            %>

                        </div>
                    </div>
                    <!-- second col----->
                    <div class="col-md-4" >
                        <!-- posts----->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh  fa-4x fa-spin"></i>
                            <h3 class="mt-2">Loading.........!</h3>
                        </div>
                        <div class="container-fluid" id="post-container">

                        </div>

                    </div>
                </div>
            </div>
        </main>


        <!--end main body of the page ----->


        <!-- start profile modal-->


        <!-- Modal -->
        <div class="modal fade" id="profile-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title" id="staticBackdropLabel"> Tech Blog</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" style="border-radius: 50%;max-width: 150px;">
                            <br>
                            <h5 class="modal-title mt-3" id="staticBackdropLabel"><%= user.getName()%></h5>

                            <!--details-->

                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID : </th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email : </th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td><%= user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Registered On :</th>
                                            <td><%= user.getDateTime().toString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- profile edit-->
                            <div id="profile-edit" style="display: none">
                                <h3 class="mt-2">Please Edit carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>Id :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td><textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile pic :</td>
                                            <td>
                                                <input type="file" name="image" class="form-control"> 
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary" >Save</button>
                                    </div>

                                </form>

                            </div>


                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--End Profile modal-->

        <!-- start add post modal-->





        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1"   aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the posts Details </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="ad-post-form" action="AddPostServlet"  method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        PostDao post = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = post.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }

                                    %>

                                </select> 
                            </div>
                            <br>
                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post Title.."class="form-control"  />
                            </div>
                            <br>
                            <div class="form-group">
                                <textarea name="pContent" class="form-control" placeholder="Enter Your Content" style="height: 200px"></textarea>
                            </div>
                            <br>
                            <div class="form-group">
                                <textarea name="pCode" class="form-control" placeholder="Enter Your programe(if any)" style="height: 200px"></textarea>
                            </div>
                            <br>
                            <div class="form-group">
                                <label>Select Your Pic..</label>
                                <br>
                                <input type="file" name="pic"  />
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>

                        </form>

                    </div>

                </div>
            </div>
        </div>

        <!--End Add post madal -->







        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script>
            $(document).ready(function () {

                let editStatus = false;
                $('#edit-profile-button').click(function () {
                    if (editStatus == false) {
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    } else {

                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus = false;
                        $(this).text("Edit");
                    }


                });
            });
        </script>

        <!--Now add post js -->
        <script>
            $(document).ready(function (e) {

                $("#ad-post-form").on("submit", function (event) {
                    //this code gets called when form  submited......

                    event.preventDefault();
                    console.log("you have submited");
                    let form = new FormData(this);
                    //now requesting to servlet
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //succses

                            console.log(data);
                            if (data.trim() == 'done') {
                                swal("Good job!", "Save successfully!", "success");
                            } else {
                                swal("Erorr!", "Something went wrong try agian", "errors");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //erorr
                            swal("Erorr!", "Something went wrong try agian", "errors");
                        },
                        processData: false,
                        contentType: false,
                    })
                })
            })
        </script>

        <!-- Loading posts using ajax -->

        <script>
            function getPosts(catId,temp) {
                $("#loader").show();
                $("#post-container").hide();
                
                $(".c-link").removeClass('active')
                
                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass('active')
                        
                    }
                })
            }

            $(document).ready(function (e) {
                
                let allPostsRef=$('.c-link')[0]
                getPosts(0,allPostsRef);
            })
        </script>

    </body>
</html>
