using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    Guid postId, postIdc, postId2c;
    Guid postKey;
    Guid postId2;
    Guid postKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static Guid sharepostId, shareuserId;
    Guid albumID;
    Guid currentUserId;
    object AlbumID;
   static List<string> names;
   static int ip;
   static Guid photoid; Guid photo_id_c;
   string user_name;
   Guid user_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Page.Title = HttpContext.Current.Session["user"].ToString();
            MembershipUser currentUser = Membership.GetUser();

            currentUserId = (Guid)currentUser.ProviderUserKey;
            (this.Master as MasterPage2).UpdateNotifications(currentUserId);

        }
        else
        {
            Response.Redirect("~/login.aspx");
        }
        try
        {
            user_name = Server.HtmlEncode(Request.QueryString["un"]);

            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select [UserId] from [aspnet_Users] WHERE [UserName]=@UserName";

            using (System.Data.SqlClient.SqlConnection myConnection = new System.Data.SqlClient.SqlConnection(connectionString2))
            {
                myConnection.Open();
                System.Data.SqlClient.SqlCommand myCommand = new System.Data.SqlClient.SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserName", user_name);


                user_id = (Guid)myCommand.ExecuteScalar();


                if (Context.Session != null)
                {

                    Session["user_id"] = user_id;

                }
                myConnection.Close();

            }
        }
        catch { }
      
    }
    protected void UserProfileDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        // Get a reference to the currently logged on user
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@UserId"].Value = user_id;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string ctype = ""; byte[] data = null;

            FileUpload fup = UserProfile.FindControl("FileUpload1") as FileUpload;


            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                //if (txtNewPost.Text != string.Empty)
                //{
                string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET ProfilePicture = @ProfilePicture WHERE UserId = @UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    if (fup.HasFile)
                    {
                        HttpPostedFile file = fup.PostedFile;
                        ctype = file.ContentType;

                        data = new byte[file.ContentLength];

                        file.InputStream.Read(data, 0, file.ContentLength);
                        myCommand.Parameters.AddWithValue("@ProfilePicture", data);
                    }


                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                string connectionString3 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

                using (SqlConnection myConnection = new SqlConnection(connectionString3))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@Name", "ProfilePictures");

                    AlbumID = myCommand.ExecuteScalar();
                    myConnection.Close();
                }

                string connectionString2 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO PhotoStore(ID, PhotoContent,UserId,UserName,Description,ContentType,UserFullName) VALUES(@ID, @PhotoContent,@UserId,@UserName,@Description,@ContentType,@UserFullName)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@ContentType", ctype);
                    myCommand.Parameters.AddWithValue("@Description", HttpContext.Current.Session["user"] + " has updated profile photo");
                    if (FileUploadProfile.HasFile)
                    {

                        myCommand.Parameters.AddWithValue("@PhotoContent", data);

                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }

                // }
            }
            //    Session["result"] = "Complete";
            //}
            Response.Redirect("~/index.aspx");
        }
        catch { }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            FileUpload fup = UserCover.FindControl("FileUpload2") as FileUpload;
            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                //if (txtNewPost.Text != string.Empty)
                //{
                string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET CoverPicture = @CoverPicture WHERE UserId = @UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    if (fup.HasFile)
                    {
                        HttpPostedFile file = fup.PostedFile;

                        byte[] data = new byte[file.ContentLength];

                        file.InputStream.Read(data, 0, file.ContentLength);
                        myCommand.Parameters.AddWithValue("@CoverPicture", data);
                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }

                // }
            }
            //    Session["result"] = "Complete";
            //}

            Response.Redirect("~/index.aspx");
        }
        catch { }
    }
    protected void ImageProfile_Click(object sender, ImageClickEventArgs e)
    {
        //Button btn = UserProfile.FindControl("Button1") as Button;

        //btn.Visible = true;

    }



    protected void ListViewPostComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey = new Guid(((Label)lvi.FindControl("PostIdLabel")).Text);

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PostId", postKey);

            MembershipUser currentUser = Membership.GetUser();

            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
                myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);

            }

            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }

        e.Cancel = true;
        this.DataBind();
    }

    protected void UserPostDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@my_id"].Value = user_id;
            e.Command.Parameters["@me"].Value = user_id;
        }
    }

    protected void UserPostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;

    }


    protected void MediaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@my_id"].Value = user_id;
            e.Command.Parameters["@me"].Value = user_id;
        }
    }

    protected void btnChangeProfile_Click(object sender, EventArgs e)
    {
        byte[] data = null;
        string imgurl = string.Empty;
        string files_types = string.Empty;
        string files = string.Empty;
        object post__id = null;


        string connectionString =
        ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string updateSql = "UPDATE UserProfiles SET ProfilePicture = @ProfilePicture WHERE UserId = @UserId";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);
            if (FileUploadProfile.HasFile)
            {
                HttpPostedFile file = FileUploadProfile.PostedFile;

                data = new byte[file.ContentLength];

                files_types = file.ContentType;

                file.InputStream.Read(data, 0, file.ContentLength);
                using (System.Drawing.Image source = byteArrayToImage(data))
                {
                    ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                    EncoderParameters parameters = new EncoderParameters(3);
                    parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                    parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                    parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                    source.Save(Server.MapPath("~") + "/uploads/" + FileUploadProfile.FileName, codec, parameters);
                    data = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + FileUploadProfile.FileName);
                }
                myCommand.Parameters.AddWithValue("@ProfilePicture", data);
            }

            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }

        string connectionString3 =
        ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

        using (SqlConnection myConnection = new SqlConnection(connectionString3))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand.Parameters.AddWithValue("@Name", "ProfilePictures");

            AlbumID = myCommand.ExecuteScalar();
            myConnection.Close();
        }

        string connectionString2 =
        ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoStore(ID,UserId,UserName,Description,ContentType,UserFullName,PostType) VALUES(@ID,@UserId,@UserName,@Description,@ContentType,@UserFullName,@PostType)";

        using (SqlConnection myConnection = new SqlConnection(connectionString2))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
            myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@ContentType", "image");
            myCommand.Parameters.AddWithValue("@PostType", "profile");
            myCommand.Parameters.AddWithValue("@Description", HttpContext.Current.Session["user"] + " has updated profile photo");
            myCommand.ExecuteNonQuery();
            string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
            SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection);
            myCommand4.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

            post__id = myCommand4.ExecuteScalar();

            myConnection.Close();

        }



        using (System.Drawing.Image source = byteArrayToImage(data))
        {
            ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
            EncoderParameters parameters = new EncoderParameters(3);
            parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
            parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

            imgurl = "/uploads/" + user_name + "/photos/profile/" + post__id + "." + files_types.Split('/').Last();
            source.Save(Server.MapPath("~") + imgurl, codec, parameters);

        }
        string connectionString21 =
  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string updateSql2 = "UPDATE PhotoStore SET ImageUrl = @ImageUrl WHERE PhotoID = @PhotoID";

        using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
        {
            myConnection3.Open();
            SqlCommand myCommand3 = new SqlCommand(updateSql2, myConnection3);
            myCommand3.Parameters.AddWithValue("@PhotoID", post__id);
            myCommand3.Parameters.AddWithValue("@ImageUrl", "~" + imgurl);
            myCommand3.ExecuteNonQuery();
            myConnection3.Close();
        }






        // }

        this.DataBind();

    }
    public System.Drawing.Image byteArrayToImage(byte[] byteArrayIn)
    {
        MemoryStream ms = new MemoryStream(byteArrayIn);
        System.Drawing.Image returnImage = System.Drawing.Image.FromStream(ms);
        return returnImage;
    }
    protected void btnChangeCover_Click(object sender, EventArgs e)
    {
        byte[] data = null;
        string imgurl = string.Empty;
        string files_types = string.Empty;
        string files = string.Empty;
        object post__id = null;
        try
        {

            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                //if (txtNewPost.Text != string.Empty)
                //{
                string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET CoverPicture = @CoverPicture WHERE UserId = @UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    if (FileUpload2.HasFile)
                    {
                        HttpPostedFile file = FileUpload2.PostedFile;

                        data = new byte[file.ContentLength];
                        files_types = file.ContentType;
                        file.InputStream.Read(data, 0, file.ContentLength);
                        using (System.Drawing.Image source = byteArrayToImage(data))
                        {
                            ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                            EncoderParameters parameters = new EncoderParameters(3);
                            parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                            parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                            parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                            source.Save(Server.MapPath("~") + "/uploads/" + FileUpload2.FileName, codec, parameters);
                            data = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + FileUpload2.FileName);
                        }
                        myCommand.Parameters.AddWithValue("@CoverPicture", data);
                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }

                string connectionString3 =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

                using (SqlConnection myConnection = new SqlConnection(connectionString3))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@Name", "CoverPhotos");

                    AlbumID = myCommand.ExecuteScalar();
                    myConnection.Close();
                }

                string connectionString2 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO PhotoStore(ID,UserId,UserName,Description,ContentType,UserFullName,PostType) VALUES(@ID,@UserId,@UserName,@Description,@ContentType,@UserFullName,@PostType)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@ContentType", "image");
                    myCommand.Parameters.AddWithValue("@PostType", "profile");
                    myCommand.Parameters.AddWithValue("@Description", HttpContext.Current.Session["user"] + " has updated cover photo");
                    myCommand.ExecuteNonQuery();
                    string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                    SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection);
                    myCommand4.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                    post__id = myCommand4.ExecuteScalar();

                    myConnection.Close();
                }
                using (System.Drawing.Image source = byteArrayToImage(data))
                {
                    ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                    EncoderParameters parameters = new EncoderParameters(3);
                    parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                    parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                    parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                    imgurl = "/uploads/" + user_name + "/photos/covers/" + post__id + "." + files_types.Split('/').Last();
                    source.Save(Server.MapPath("~") + imgurl, codec, parameters);

                }
                string connectionString21 =
          ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql2 = "UPDATE PhotoStore SET ImageUrl = @ImageUrl WHERE PhotoID = @PhotoID";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(updateSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@PhotoID", post__id);
                    myCommand3.Parameters.AddWithValue("@ImageUrl", "~" + imgurl);
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }

                // }
            }
            this.DataBind();
        }
        catch { }
    }
    protected void PostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;
        //string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        ////string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
        //string selectSql = "SELECT COUNT(*) FROM [UserComments] WHERE ([PostId] = @PostId)";


        //using (SqlConnection myConnection = new SqlConnection(connectionString2))
        //{
        //    myConnection.Open();
        //    SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
        //    myCommand.Parameters.AddWithValue("@PostId", postId);


        //    Int32 count = (Int32)myCommand.ExecuteScalar();

        //    if (count > 3)
        //    {
        //        DataSourceSelectArguments ds;

        //        PostCommentDataSource.SelectCommand = "SELECT TOP 3 * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]";



        //    }
        //    else
        //    {
        //        PostCommentDataSource.SelectCommand = "SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]";


        //    }

        //    myConnection.Close();

        //}


    }
    protected void ListViewMediaComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey2 = new Guid(((Label)lvi.FindControl("PostIdLabel")).Text);

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PostId", postKey2);

            MembershipUser currentUser = Membership.GetUser();

            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
                myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);

            }

            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }

        e.Cancel = true;
        this.DataBind();
    }
    protected void MediaCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId2;
    }

    protected void LinkButtonComment_Click(object sender, EventArgs e)
    {


    }
    protected void LinkButtonLike_Click(object sender, EventArgs e)
    {

        string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@LikeId", likeId);
            myCommand.Parameters.AddWithValue("@LikeUser", HttpContext.Current.Session["user"]);

            MembershipUser currentUser = Membership.GetUser();

            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                myCommand.Parameters.AddWithValue("@UserId", currentUserId);


            }

            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }
    }

    protected void ListViewPostComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postIdc = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userIdc = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;



            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeIdc);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }



        }
        catch { }

        if ((e.Item != null) && (e.Item.ItemType == ListViewItemType.InsertItem))
        {
            ImageButton imgin = e.Item.FindControl("ImageProfile5") as ImageButton;
            imgin.ImageUrl = "ThumbnailHandlerPost.ashx?userid=" + currentUserId;

        }
    }
    protected void ListViewPostComment_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            String like_Id = likeidlbl.Text;
            likeId_inc = new Guid(likeidlbl.Text);
            MembershipUser currentUser = Membership.GetUser();
            string post_userId = e.CommandArgument.ToString();
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;


            //if (String.Equals(lbtn.Text , "Like"))
            //{

            ImageButton lb = e.Item.FindControl("LinkButtonLike") as ImageButton;
            LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;

            System.Data.SqlClient.SqlDataReader rdr = null;
            System.Data.SqlClient.SqlConnection conn = null;
            System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [UserLikes]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                //if (rdr.HasRows)
                //{
                while (rdr.Read())
                {
                    String usrid = rdr["UserId"].ToString();
                    String lkid = rdr["LikeId"].ToString();
                    if (user_Id == usrid && like_Id == lkid)
                    {
                        string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
                        string Sql = "delete from [UserLikes] WHERE LikeId=@LikeId and UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(connectionString10))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                            myCommand.Parameters.AddWithValue("@LikeId", new Guid(like_Id));
                            myCommand.Parameters.AddWithValue("@UserId", new Guid(user_Id));

                            myCommand.ExecuteNonQuery();

                            myConnection.Close();

                        }
                        return;
                        //rdr.NextResult();
                    }

                }
                string connectionString11 =
                      ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString11))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                    myCommand.Parameters.AddWithValue("@LikeUser", HttpContext.Current.Session["user"]);



                    myCommand.Parameters.AddWithValue("@UserId", user_Id);




                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }
                string connectionString5 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [Notifications]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                //if (rdr.HasRows)
                //{
                while (rdr.Read())
                {
                    String usrid = rdr["UserId"].ToString();
                    String lkid = rdr["LikeId"].ToString();
                    String notify = rdr["NotifyTo"].ToString();
                    if (user_Id == usrid && like_Id == lkid && notify == post_userId)
                    { return; }
                }
                if (user_Id != post_userId)
                {
                    string connectionString12 =
                          ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo,PostId) VALUES(@UserId,@LikeId,@Type,@NotifyTo,@PostId)";

                    using (SqlConnection myConnection = new SqlConnection(connectionString12))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                        myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                        myCommand.Parameters.AddWithValue("@Type", "Comment_Like");
                        myCommand.Parameters.AddWithValue("@UserId", user_Id);
                        myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
                        ListView lstview = sender as ListView;
                        Guid post__id = (Guid)lstview.DataKeys[e.Item.DataItemIndex].Values[0];
                        myCommand.Parameters.AddWithValue("@PostId", post__id);

                        myCommand.ExecuteNonQuery();
                        myConnection.Close();

                    }

                }

                if (rdr != null)
                    rdr.Close();
            }
            catch (Exception ex)
            {

            }

            finally
            {
                if (conn != null)
                    conn.Close();
                this.DataBind();
            }
        
        }
    }

    protected void ListViewMediaComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postId2c = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId2c = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId2c = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;

            System.Data.SqlClient.SqlDataReader rdr = null;
            System.Data.SqlClient.SqlConnection conn = null;
            System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [UserLikes]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();


                while (rdr.Read())
                {
                    String uid = rdr["UserId"].ToString();
                    String lid = rdr["LikeId"].ToString();
                    if (userId2c == uid && likeId2c == lid)
                    {
                        lb.Text = "Unlike";
                        break;

                    }
                    else
                    {
                        lb.Text = "Like";

                    }

                }
                if (rdr != null)
                    rdr.Close();
            }
            catch (Exception ex)
            {

            }

            finally
            {
                if (conn != null)
                    conn.Close();
            }

            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeId2c);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }



        }
        catch { }
    }

    protected void ListViewMediaComment_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            String like_Id = likeidlbl.Text;
            likeId_inc = new Guid(likeidlbl.Text);
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;


            //if (String.Equals(lbtn.Text , "Like"))
            //{

            ImageButton lb = e.Item.FindControl("LinkButtonLike") as ImageButton;
            LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;

            System.Data.SqlClient.SqlDataReader rdr = null;
            System.Data.SqlClient.SqlConnection conn = null;
            System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [UserLikes]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                //if (rdr.HasRows)
                //{
                while (rdr.Read())
                {
                    String usrid = rdr["UserId"].ToString();
                    String lkid = rdr["LikeId"].ToString();
                    if (user_Id == usrid && like_Id == lkid)
                    {
                        string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
                        string Sql = "delete from [UserLikes] WHERE LikeId=@LikeId and UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(connectionString10))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                            myCommand.Parameters.AddWithValue("@LikeId", new Guid(like_Id));
                            myCommand.Parameters.AddWithValue("@UserId", new Guid(user_Id));

                            myCommand.ExecuteNonQuery();

                            myConnection.Close();

                        }
                        return;
                        //rdr.NextResult();
                    }

                }
                string connectionString11 =
                      ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString11))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                    myCommand.Parameters.AddWithValue("@LikeUser", HttpContext.Current.Session["user"]);



                    myCommand.Parameters.AddWithValue("@UserId", user_Id);




                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }


                if (rdr != null)
                    rdr.Close();
            }
            catch (Exception ex)
            {

            }

            finally
            {
                if (conn != null)
                    conn.Close();
                this.DataBind();
            }

        }
    }
    protected void ImageButtonGrid_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/index.aspx");
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/profile-list.aspx");
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedIndex == 0)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Friends"));
            MenuSub.Items.Add(new MenuItem("Family"));
            MenuSub.Items.Add(new MenuItem("Acquaintance"));
            MenuSub.Items.Add(new MenuItem("More..."));
            MenuSub.Items.Add(new MenuItem("+"));


        }
        if (DropDownList1.SelectedIndex == 1)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Friends"));
            MenuSub.Items.Add(new MenuItem("Family"));
            MenuSub.Items.Add(new MenuItem("Acquaintance"));
            MenuSub.Items.Add(new MenuItem("More..."));
            MenuSub.Items.Add(new MenuItem("+"));


        }
        if (DropDownList1.SelectedIndex == 2)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Personal"));
            MenuSub.Items.Add(new MenuItem("Entertainment"));
            MenuSub.Items.Add(new MenuItem("Company"));
            MenuSub.Items.Add(new MenuItem("More..."));
            MenuSub.Items.Add(new MenuItem("+"));


        }
        if (DropDownList1.SelectedIndex == 3)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Personal"));
            MenuSub.Items.Add(new MenuItem("Entertainment"));
            MenuSub.Items.Add(new MenuItem("Company"));
            MenuSub.Items.Add(new MenuItem("More..."));
            MenuSub.Items.Add(new MenuItem("+"));


        }
    }
    protected void UserProfile_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }






    protected void PhotoAlbumsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@UserId"].Value = user_id;
        }
    }
    protected void NameLabel_Click(object sender, EventArgs e)
    {
       
        
        //ListView1.Visible = false;
     
        //ListView2.Visible = true;
        //ListView2.DataBind();

    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        albumID = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
        if (String.Equals(e.CommandName, "showalbum"))
        {
            Response.Redirect("~/photoalbums.aspx?albumid=" + e.CommandArgument.ToString()); 
        }
    }
    protected void PhotoStoreDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@ID"].Value = albumID;
    }
    protected void btnNewAlbum_Click(object sender, EventArgs e)
    {

    }
    protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        try
        {
            byte[] image = e.GetContents();
            string ctype = "image";

            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                currentUserId = (Guid)currentUser.ProviderUserKey;


                string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET BackgroundPicture = @BackgroundPicture WHERE UserId = @UserId";
                try
                {
                    using (SqlConnection myConnection = new SqlConnection(connectionString))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                        myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                        myCommand.Parameters.AddWithValue("@BackgroundPicture", image);
                        myCommand.ExecuteNonQuery();
                        myConnection.Close();
                    }
                }
                catch { }

                string connectionString3 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

                using (SqlConnection myConnection = new SqlConnection(connectionString3))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@Name", "BackgroundPhotos");

                    AlbumID = myCommand.ExecuteScalar();
                    myConnection.Close();
                }

                string connectionString2 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO PhotoStore(ID, PhotoContent,UserId,UserName,Description,ContentType,UserFullName) VALUES(@ID, @PhotoContent,@UserId,@UserName,@Description,@ContentType,@UserFullName)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Description", HttpContext.Current.Session["user"] + " has updated background photo");
                    myCommand.Parameters.AddWithValue("@ContentType", ctype);
                    myCommand.Parameters.AddWithValue("@PhotoContent", image);



                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            e.DeleteTemporaryData();
        }
        catch { }
        this.DataBind();
      
    }
    protected void AjaxFileUpload1_UploadCompleteAll(object sender, AjaxControlToolkit.AjaxFileUploadCompleteAllEventArgs e)
    {

    }
    protected void btnAlbumCreate_Click(object sender, EventArgs e)
    {
      
        string imgurl = string.Empty;
        string files_types = string.Empty;
    
        object post__id = null;
        string files = uploaded_files.Value;
         names = files.Split(',').ToList<string>();
        if (!string.IsNullOrEmpty(txtAlbumName.Text))
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO PhotoAlbums(Name, UserId,Location) VALUES(@Name, @UserId,@Location)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@Name", txtAlbumName.Text);
                myCommand.Parameters.AddWithValue("@Location", txtLocation.Text);
                MembershipUser currentUser = Membership.GetUser();
                if (currentUser != null)
                {
                    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                }

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            string connectionString3 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

            using (SqlConnection myConnection = new SqlConnection(connectionString3))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@Name", txtAlbumName.Text);

                AlbumID = myCommand.ExecuteScalar();
                myConnection.Close();
            }
            for (int i = 0; i < names.Count; i++)
            {
                byte[] image = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + names[i]);
                string connectionString2 =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql2 = "INSERT INTO PhotoStore(ID, ImageUrl,UserId,UserName,Title,ContentType,UserFullName) VALUES(@ID, @ImageUrl,@UserId,@UserName,@Title,@ContentType,@UserFullName)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Title", HttpContext.Current.Session["user"]+" has uploaded a new album");
                    myCommand.Parameters.AddWithValue("@ImageUrl", "image");
                    myCommand.Parameters.AddWithValue("@ContentType", "image");
                    myCommand.ExecuteNonQuery();
                    string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                    SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection);
                    myCommand4.Parameters.AddWithValue("@UserId", user_id);
                    myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                    post__id = myCommand4.ExecuteScalar();
                    myConnection.Close();
                }
                try
                {


                    using (System.Drawing.Image source = System.Drawing.Image.FromFile(Server.MapPath("~") + "/uploads/" + names[i]))
                    {
                        ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                        EncoderParameters parameters = new EncoderParameters(3);
                        parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                        parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                        parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                        imgurl = "/uploads/" + user_name + "/photos/posts/" + post__id + ".jpeg";
                        source.Save(Server.MapPath("~") + imgurl, codec, parameters);

                    }
                    string connectionString21 =
              ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string updateSql = "UPDATE PhotoStore SET ImageUrl = @ImageUrl WHERE PhotoID = @PhotoID";

                    using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                    {
                        myConnection3.Open();
                        SqlCommand myCommand3 = new SqlCommand(updateSql, myConnection3);
                        myCommand3.Parameters.AddWithValue("@PhotoID", post__id);
                        myCommand3.Parameters.AddWithValue("@ImageUrl", "~" + imgurl);
                        myCommand3.ExecuteNonQuery();
                        myConnection3.Close();
                    }
                    System.IO.File.Delete(Server.MapPath("~") + "/uploads/" + files);
                    uploaded_files.Value = string.Empty;
                    //uploaded_files_type_photo.Value = string.Empty;
                }
                catch
                {

                }
            }
        
            Image1.ImageUrl = "~/uploads/" + names[0];
            ModalPopupExtenderGallery.Show();

        }
        else
        {
            return;
        }
        //lblAlbum.Visible = false;
        //txtAlbumName.Visible = false;
        //btnAlbumCreate.Visible = false;
        //AjaxFileUpload1.Visible = true;
        //ModalPopupExtender2.Show();
        this.DataBind();
    }
    protected void btnNewAlbumCancel_Click(object sender, EventArgs e)
    {
        lblAlbum.Visible = true;
        txtAlbumName.Visible = true;
        btnAlbumCreate.Visible = true;
        //AjaxFileUpload1.Visible = false;
    }
    protected void AjaxFileUpload1_UploadStart(object sender, AjaxControlToolkit.AjaxFileUploadStartEventArgs e)
    {
        if (string.IsNullOrEmpty(txtAlbumName.Text))
        {

        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        try
        {
            ip = ip + 1;
            Image1.ImageUrl = "~/uploads/" + names[ip];
        }
        catch { }
    }
    protected void btnVideo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/videos.aspx?un=" + user_name);
    }
    protected void btnPhoto_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/photos.aspx?un=" + user_name);
    }

    protected void btnAbout_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/about.aspx?un=" + user_name);
    }
    protected void btnFriend_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/friends.aspx?un=" + user_name);

    }
    //protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    //{
    //    if (String.Equals(e.CommandName, "cmdDescription"))
    //    {
    //        ((Panel)e.Item.FindControl("pnlDescription")).Visible = true;
            
    //    }
    //    if (String.Equals(e.CommandName, "newcomment"))
    //    {
    //        //ListView lv = (ListView)sender;
    //        //Panel lvi = (Panel)lv.Parent;
    //        //postKey = new Guid(((Label)lvi.FindControl("PostIdLabel")).Text);
    //        String postKey = ListView2.DataKeys[e.Item.DataItemIndex].Values[0].ToString();

    //        string post_userId = ListView2.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

    //        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


    //        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
    //        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId)";

    //        using (SqlConnection myConnection = new SqlConnection(connectionString))
    //        {
    //            myConnection.Open();
    //            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
    //            myCommand.Parameters.AddWithValue("@Comment", ((TextBox)e.Item.FindControl("txtComment")).Text);
    //            myCommand.Parameters.AddWithValue("@PhotoID", postKey);



    //            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
    //            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);



    //            myCommand.ExecuteNonQuery();
    //            myConnection.Close();

    //        }
    //        if (currentUserId.ToString() != post_userId)
    //        {
    //            string connectionString12 =
    //                  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


    //            string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo) VALUES(@UserId,@Type,@NotifyTo)";

    //            using (SqlConnection myConnection = new SqlConnection(connectionString12))
    //            {
    //                myConnection.Open();
    //                SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);

    //                myCommand.Parameters.AddWithValue("@Type", "Post_Comment");
    //                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
    //                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
    //                myCommand.ExecuteNonQuery();
    //                myConnection.Close();

    //            }

    //        }

          
    //        this.DataBind();
    //    }
    //    if (String.Equals(e.CommandName, "popimage"))
    //    {
            
            
    //        ((ListView)e.Item.FindControl("ListView3")).Visible = true;
    //        photoid = new Guid(e.CommandArgument.ToString());
    //        this.DataBind();
         
    //    }

    //    if (String.Equals(e.CommandName, "LikeButton"))
    //    {
    //        //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
    //        //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
    //        //likeId_in = (Guid)ListView2.DataKeys[e.Item.DataItemIndex].Values[1];
    //        String like_Id = e.CommandArgument.ToString();
    //        String post_userId = ListView2.DataKeys[e.Item.DataItemIndex].Values[0].ToString();

    //        String user_Id = currentUserId.ToString();

    //        //if (String.Equals(lbtn.Text , "Like"))
    //        //{

    //        ImageButton lb = e.Item.FindControl("LinkButtonLike2") as ImageButton;
    //        LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;

    //        System.Data.SqlClient.SqlDataReader rdr = null;
    //        System.Data.SqlClient.SqlConnection conn = null;
    //        System.Data.SqlClient.SqlCommand sqlcmd = null;

    //        try
    //        {
    //            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
    //            conn = new System.Data.SqlClient.SqlConnection(connectionString);

    //            sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [UserLikes]", conn);
    //            conn.Open();

    //            rdr = sqlcmd.ExecuteReader();

    //            //if (rdr.HasRows)
    //            //{
    //            while (rdr.Read())
    //            {
    //                String usrid = rdr["UserId"].ToString();
    //                String lkid = rdr["LikeId"].ToString();
    //                if (user_Id == usrid && like_Id == lkid)
    //                {
    //                    string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
    //                    //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
    //                    string Sql = "delete from [UserLikes] WHERE LikeId=@LikeId and UserId=@UserId";

    //                    using (SqlConnection myConnection = new SqlConnection(connectionString10))
    //                    {
    //                        myConnection.Open();
    //                        SqlCommand myCommand = new SqlCommand(Sql, myConnection);
    //                        myCommand.Parameters.AddWithValue("@LikeId", new Guid(like_Id));
    //                        myCommand.Parameters.AddWithValue("@UserId", new Guid(user_Id));

    //                        myCommand.ExecuteNonQuery();

    //                        myConnection.Close();

    //                    }
    //                    return;
    //                    //rdr.NextResult();
    //                }

    //            }
    //            string connectionString11 =
    //                  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


    //            string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

    //            using (SqlConnection myConnection = new SqlConnection(connectionString11))
    //            {
    //                myConnection.Open();
    //                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
    //                myCommand.Parameters.AddWithValue("@LikeId", like_Id);
    //                myCommand.Parameters.AddWithValue("@LikeUser", HttpContext.Current.Session["user"]);



    //                myCommand.Parameters.AddWithValue("@UserId", user_Id);




    //                myCommand.ExecuteNonQuery();
    //                myConnection.Close();

    //            }
    //            string connectionString5 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
    //            conn = new System.Data.SqlClient.SqlConnection(connectionString);

    //            sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [Notifications]", conn);
    //            conn.Open();

    //            rdr = sqlcmd.ExecuteReader();

    //            //if (rdr.HasRows)
    //            //{
    //            while (rdr.Read())
    //            {
    //                String usrid = rdr["UserId"].ToString();
    //                String lkid = rdr["LikeId"].ToString();
    //                String notify = rdr["NotifyTo"].ToString();
    //                if (user_Id == usrid && like_Id == lkid && notify == post_userId)
    //                { return; }
    //            }

    //            if (user_Id != post_userId)
    //            {
    //                string connectionString12 =
    //                      ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


    //                string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo) VALUES(@UserId,@LikeId,@Type,@NotifyTo)";

    //                using (SqlConnection myConnection = new SqlConnection(connectionString12))
    //                {
    //                    myConnection.Open();
    //                    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
    //                    myCommand.Parameters.AddWithValue("@LikeId", like_Id);
    //                    myCommand.Parameters.AddWithValue("@Type", "Post_Like");
    //                    myCommand.Parameters.AddWithValue("@UserId", user_Id);
    //                    myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
    //                    myCommand.ExecuteNonQuery();
    //                    myConnection.Close();

    //                }

    //            }


    //            if (rdr != null)
    //                rdr.Close();
    //        }
    //        catch (Exception ex)
    //        {

    //        }

    //        finally
    //        {
    //            if (conn != null)
    //                conn.Close();
    //            this.DataBind();
    //        }
    //    }

    //    if (String.Equals(e.CommandName, "DescriptionUpdate"))
    //    {
        
            
    //        string connectionString =
    //       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
    //        string updateSql = "UPDATE [PhotoStore] SET [Description] = @Description WHERE [PhotoID] = @PhotoID";

    //        using (SqlConnection myConnection = new SqlConnection(connectionString))
    //        {
    //            myConnection.Open();
    //            SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
    //            myCommand.Parameters.AddWithValue("@Description", ((TextBox)e.Item.FindControl("txtDescription")).Text);
    //            myCommand.Parameters.AddWithValue("@PhotoID", e.CommandArgument.ToString());
           



    //            myCommand.ExecuteNonQuery();
    //            myConnection.Close();
    //        }
            
           
         
    //    }
    //}
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void ListView3_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;

        System.Web.UI.Control lvi = (System.Web.UI.Control)lv.Parent;
        //Panel lvii = (Panel)lvi.Parent;
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        postKey = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);





        //   Guid postKey3 = (Guid)lvi.DataKeys[e.Item.DataItemIndex].Values[0];
        //string   post_userId = ( ((Label)ListView2.FindControl("UserIdLabel")).Text);


        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PhotoID", postKey);


            myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);
            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);



            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }
        try
        {
            if (currentUserId.ToString() != post_userId)
            {
                string connectionString12 =
                      ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo,PostId) VALUES(@UserId,@Type,@NotifyTo,@PostId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString12))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);

                    myCommand.Parameters.AddWithValue("@Type", "Post_Comment");
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
                    myCommand.Parameters.AddWithValue("@PostId", postKey);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }

            }
        }
        catch { }

        e.Cancel = true;
        //MediaDS.SelectCommand = "SELECT * FROM [PhotoComments] WHERE ([PhotoID] = '" + postKey + "') ORDER BY [CommentDate]";


        //MediaDS.DataBind();
        //ListView4.DataBind();
    }
  
    protected void MediaDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = photo_id_c;
    }
    protected void ListView2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            photo_id_c = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            //userIdc = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;
         


            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeIdc);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }



        }
        catch { }
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //e.Command.Parameters["@PhotoID"].Value = photoid;
    }
    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        ListView lv = (ListView)sender;
        Guid photo_id = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
        HyperLink hlv = e.Item.FindControl("HyperLinkViewer") as HyperLink;
        hlv.NavigateUrl = "~/photoviewer.aspx?photoid=" + photo_id.ToString();
    }
    protected void PhotoCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = photoid;
    }
    protected void ListView3_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        ListView lv = (ListView)sender;
       Guid photoid = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
    }
}