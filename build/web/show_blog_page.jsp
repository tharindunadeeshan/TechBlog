<%@page import="com.tech.blog.dao.Likedao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %> 

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>


<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> || TechBlog Learn code with nadeeshan</title>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/styles.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(33% 0, 70% 0%, 100% 0, 100% 100%, 70% 99%, 30% 100%, 0 94%, 0 0);
            }

            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;

            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
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
                        <a class="nav-link active" aria-current="page" href="profile.jsp"><span class="fa fa-bell-o"></span> LearnCode With Nadeeshan</a>
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

    <!-- start  main content of body ----->
    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header primary-background text-white">
                        <h4 class="post-title"><%= p.getpTitle()%></h4>
                    </div>
                    <div class="card-body">
                        <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top my-2" alt="...">
                        <div class="row my-3 row-user">
                            <div class="col-md-8">

                                <% UserDao ud = new UserDao(ConnectionProvider.getConnection());%>
                                <p class="post-user-info"><a href="#!"><%= ud.getUserByUserId(p.getUserId()).getName()%></a> has posted:</p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                            </div>
                        </div>

                        <p class="post-content"><%= p.getpContent()%></p>
                        <br>
                        <br>
                        <div class="post-code">
                            <pre><%= p.getpCode()%></pre>
                        </div>
                    </div>
                    <div class="card-footer primary-background">

                        <%
                            Likedao ld = new Likedao(ConnectionProvider.getConnection());

                        %>
                        <a  href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btm-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></i></a>
                        <a  href="#!" class="btn btn-outline-light btm-sm"><i class="fa fa-commenting-o"><span>20</span></i></a>
                    </div>
                   

                </div>
            </div>
        </div>
    </div>
    <!-- end of main content of body----->
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


</body>
</html>
