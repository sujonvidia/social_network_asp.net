using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Drawing.Imaging;


public partial class Default3 : System.Web.UI.Page
{
    public TextBox tb;
    public Label lbl;
    public string txt;
    Guid postId, postIdc, postId2c, postId_edit;
    Guid postKey;
    Guid postId2;
    Guid postKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static Guid sharepostId, shareuserId;
    Guid currentUserId;
    static HttpPostedFile filep;
    static byte[] data, data2;
    string user_name;
    Guid user_id;
    object AlbumID;
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
            if (Request.Cookies["user_name"] != null)
            {
                if (!String.IsNullOrEmpty(Request.Cookies["user_name"].Value))
                {
                    user_name = Request.Cookies["user_name"].Value;
                }
            }

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
        ImageProfile.ImageUrl = "ThumbnailHandlerProfile.ashx?userid=" + currentUserId;
        shareuserId = currentUserId;
    }
    protected void btnNewPost_Click(object sender, EventArgs e)
    {
        byte[] image = null;
        string imgurl = string.Empty;
        string files_types = string.Empty;
        string files = string.Empty;
        object post__id = null;

        int i = TabContainerPost.ActiveTabIndex;

        //if (Session["result"] != "Complete")
        //{

        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            currentUserId = (Guid)currentUser.ProviderUserKey;

            //if (txtNewPost.Text != string.Empty)
            //{


            if (i == 0)
            {
                string connectionString =
             ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql2 = "INSERT INTO PhotoStore(PostUserId,Post,UserId,UserName,UserFullName,ContentType,Privacy,PostType) VALUES(@PostUserId,@Post,@UserId,@UserName,@UserFullName,@ContentType,@Privacy,@PostType)";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@Post", txtNewPost.Text);
                    myCommand3.Parameters.AddWithValue("@UserId", user_id);
                    myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                    myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand3.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);

                    myCommand3.Parameters.AddWithValue("@Privacy", ddlPrivacy.SelectedValue);
                    myCommand3.Parameters.AddWithValue("@ContentType", "post");
                    myCommand3.Parameters.AddWithValue("@PostType", "profile");
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                    //              string connectionString3 =
                    //ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    //              string selectSql = "select [PostId] from [UserPosts] where ([UserId]=@UserId and PostUserId=@PostUserId) order by [PostDate] desc";

                    //              using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
                    //              {
                    //                  myConnection2.Open();
                    //                  SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
                    //                  myCommand2.Parameters.AddWithValue("@UserId", user_id);
                    //                  myCommand2.Parameters.AddWithValue("@PostUserId", currentUserId);

                    //                  post__id = myCommand2.ExecuteScalar();
                    //                  myConnection2.Close();
                    //              }

                }
            }
            if (i == 1)
            {
                files = uploaded_files_photo.Value;
                files_types = uploaded_files_type_photo.Value;

                //files_types = files_types.Remove(files_types.Length - 1);
                if (System.IO.File.Exists(Server.MapPath("~") + "/uploads/" + files))
                {

                    string connectionString3 =
         ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

                    using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
                    {
                        myConnection2.Open();
                        SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
                        myCommand2.Parameters.AddWithValue("@UserId", user_id);
                        myCommand2.Parameters.AddWithValue("@Name", "PostPhotos");

                        AlbumID = myCommand2.ExecuteScalar();
                        myConnection2.Close();
                    }

                    string connectionString2 =
                    ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string insertSql2 = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,UserFullName,ContentType,Description,Privacy,PostType) VALUES(@PostUserId,@ID,@UserId,@UserName,@UserFullName,@ContentType,@Description,@Privacy,@PostType)";

                    using (SqlConnection myConnection3 = new SqlConnection(connectionString2))
                    {
                        myConnection3.Open();
                        SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                        myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                        myCommand3.Parameters.AddWithValue("@UserId", user_id);
                        myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                        myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                        myCommand3.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                        myCommand3.Parameters.AddWithValue("@Description", txtPhotoPost.Text.Trim());
                        myCommand3.Parameters.AddWithValue("@Privacy", ddlPrivacy.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "image");
                        myCommand3.Parameters.AddWithValue("@PostType", "profile");



                        myCommand3.ExecuteNonQuery();
                        string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                        SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection3);
                        myCommand4.Parameters.AddWithValue("@UserId", user_id);
                        myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                        post__id = myCommand4.ExecuteScalar();
                        myConnection3.Close();
                    }
                    try
                    {


                        using (System.Drawing.Image source = System.Drawing.Image.FromFile(Server.MapPath("~") + "/uploads/" + files))
                        {
                            ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                            EncoderParameters parameters = new EncoderParameters(3);
                            parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                            parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                            parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                            imgurl = "/uploads/" + user_name + "/photos/posts/" + post__id + "." + files_types.Split('/').Last();
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
                        uploaded_files_photo.Value = string.Empty;
                        uploaded_files_type_photo.Value = string.Empty;
                    }
                    catch
                    {

                    }
                }
                else
                {
                    string script = "alert('Already uploaded.Please upload again!')";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "photo/video", script, true);
                    return;
                }
            }
            if (i == 3)
            {

                //try
                //{
                //    files = uploaded_files_photo.Value;
                //    files_types = uploaded_files_type_photo.Value;
                //    //files_types = files_types.Remove(files_types.Length - 1);
                //    image = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + files);

                //    using (System.Drawing.Image source = System.Drawing.Image.FromFile(Server.MapPath("~") + "/uploads/" + files))
                //    {
                //        ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                //        EncoderParameters parameters = new EncoderParameters(3);
                //        parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                //        parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                //        parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);
                //        System.IO.File.Delete(Server.MapPath("~") + "/uploads/" + files);

                //        source.Save(Server.MapPath("~") + "/uploads/" + files, codec, parameters);
                //        image = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + files);
                //    }
                //}
                //catch { }
                string connectionString3 =
     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

                using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
                {
                    myConnection2.Open();
                    SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
                    myCommand2.Parameters.AddWithValue("@UserId", user_id);
                    myCommand2.Parameters.AddWithValue("@Name", "PostPhotos");

                    AlbumID = myCommand2.ExecuteScalar();
                    myConnection2.Close();
                }

                string connectionString2 =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql2 = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,UserFullName,Description,Link,Privacy,PostType,ContentType) VALUES(@PostUserId,@ID,@UserId,@UserName,@UserFullName,@Description,@Link,@Privacy,@PostType,@ContentType)";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString2))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand3.Parameters.AddWithValue("@UserId", user_id);
                    myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                    myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand3.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand3.Parameters.AddWithValue("@Description", txtLinkPost.Text.Trim());
                    myCommand3.Parameters.AddWithValue("@Link", linkpost.Value);
                    //myCommand3.Parameters.AddWithValue("@ContentType", files_types);
                    myCommand3.Parameters.AddWithValue("@Privacy", ddlPrivacy.SelectedValue);
                    myCommand3.Parameters.AddWithValue("@PostType", "profile");
                    myCommand3.Parameters.AddWithValue("@ContentType", "link");


                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }
            }
            if (i == 2)
            {


                files = uploaded_files_video.Value;
                files_types = uploaded_files_type_video.Value;
                //files_types = files_types.Remove(files_types.Length - 1);
                image = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + files);
                if (System.IO.File.Exists(Server.MapPath("~") + "/uploads/" + files))
                {

                    string connectionString3 =
        ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string selectSql = "SELECT ID FROM VideoAlbums WHERE UserId=@UserId AND Name=@Name";

                    using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
                    {
                        myConnection2.Open();
                        SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
                        myCommand2.Parameters.AddWithValue("@UserId", user_id);
                        myCommand2.Parameters.AddWithValue("@Name", "PostVideos");

                        AlbumID = myCommand2.ExecuteScalar();
                        myConnection2.Close();
                    }

                    string connectionString2 =
                    ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string insertSql2 = " INSERT INTO VideoStore(PostUserId,ID,UserId,UserName,ContentType,UserFullName,Description,Privacy,PostType) VALUES(@PostUserId,@ID,@UserId,@UserName,@ContentType,@UserFullName,@Description,@Privacy,@PostType)";

                    using (SqlConnection myConnection3 = new SqlConnection(connectionString2))
                    {
                        myConnection3.Open();
                        SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                        myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                        myCommand3.Parameters.AddWithValue("@UserId", user_id);
                        myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                        myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                        myCommand3.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                        myCommand3.Parameters.AddWithValue("@Description", txtVideoPost.Text.Trim());
                        myCommand3.Parameters.AddWithValue("@Privacy", ddlPrivacy.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "video");
                        myCommand3.Parameters.AddWithValue("@PostType", "profile");

                        myCommand3.ExecuteNonQuery();
                        string selectSql2 = "select [VideoID] from [VideoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                        SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection3);
                        myCommand4.Parameters.AddWithValue("@UserId", user_id);
                        myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                        post__id = myCommand4.ExecuteScalar();
                        myConnection3.Close();
                        myConnection3.Close();
                    }
                    try
                    {
                        imgurl = "/uploads/" + user_name + "/videos/posts/" + post__id + "." + files_types.Split('/').Last();
                        File.Move(Server.MapPath("~") + "/uploads/" + files, Server.MapPath("~") + imgurl);


                        string connectionString21 =
                  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        string updateSql = "UPDATE VideoStore SET VideoUrl = @VideoUrl WHERE VideoID = @VideoID";

                        using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                        {
                            myConnection3.Open();
                            SqlCommand myCommand3 = new SqlCommand(updateSql, myConnection3);
                            myCommand3.Parameters.AddWithValue("@VideoID", post__id);
                            myCommand3.Parameters.AddWithValue("@VideoUrl", "~" + imgurl);
                            myCommand3.ExecuteNonQuery();
                            myConnection3.Close();
                        }
                        System.IO.File.Delete(Server.MapPath("~") + "/uploads/" + files);
                        uploaded_files_video.Value = string.Empty;
                        uploaded_files_type_video.Value = string.Empty;
                    }
                    catch
                    {

                    }
                }
                else
                {
                    string script = "alert('Already uploaded.Please upload again!')";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "photo/video", script, true);
                    return;
                }
            }




            if (i == 1 || i == 2)
            {

                if (string.IsNullOrEmpty(files))
                {
                    string script = "alert('Add photo/video!')";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "photo/video", script, true);
                    return;
                }
            }
            image = null;

        }

        // }

        txtNewPost.Text = "";
        if (user_id != currentUserId)
        {
            string connectionString12 =
                  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


            string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo,PostId) VALUES(@UserId,@Type,@NotifyTo,@PostId)";

            using (SqlConnection myConnection = new SqlConnection(connectionString12))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                //myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                myCommand.Parameters.AddWithValue("@Type", "Post_New");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", user_id);
                //ListView lstview = sender as ListView;
                //Guid post__id = (Guid)lstview.DataKeys[e.Item.DataItemIndex].Values[0];
                myCommand.Parameters.AddWithValue("@PostId", post__id);

                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        //ScriptManager.RegisterClientScriptBlock(this, GetType(), "ClearPostBox", "ClearPostBox();", true);
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>ClearPostBox();</script>", false);

        ListView1.DataBind();

        UpdatePanel1.Update();

       
    }
    protected void MediaDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = postId;
    }
    protected void PostsDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = currentUserId;

        }
        else FormsAuthentication.RedirectToLoginPage();
    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

        System.Web.UI.HtmlControls.HtmlAnchor hlp = e.Item.FindControl("photo_popup") as System.Web.UI.HtmlControls.HtmlAnchor;
        Control popdiv = e.Item.FindControl("inline_content") as Control;
        hlp.HRef = "#" + popdiv.ClientID;
        ListView lv = (ListView)sender;
        Guid photo_id = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
        string mediatype = lv.DataKeys[e.Item.DataItemIndex].Values[3].ToString();
        HyperLink hlv = e.Item.FindControl("HyperLinkViewer") as HyperLink;
        hlv.NavigateUrl = "~/photoviewer.aspx?photoid=" + photo_id.ToString();
       
        try
        {
            if (mediatype.Contains("video"))
            {


                Panel myVideo = (Panel)e.Item.FindControl("pnlVideo");
                myVideo.Visible = true;
            }
            if (mediatype.Contains("image"))
            {


                ImageButton myImage = (ImageButton)e.Item.FindControl("imgbtn");
                myImage.Visible = true;
            }
            if (mediatype.Contains("video") && mediatype.Contains("image"))
            {

               
                Panel myDiv = (Panel)e.Item.FindControl("post_backcolor");
                myDiv.Attributes.Add("style", "background-color:white;");
            }
        }
        catch { }
    }


    protected void CommentsDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;
    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        String like_Id = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
        MembershipUser currentUser = Membership.GetUser();

        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        String user_Id = currentUserId.ToString();
        String post_userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();


        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            likeId_in = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[1];

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
                        myCommand.Parameters.AddWithValue("@Type", "Post_Like");
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

        if (String.Equals(e.CommandName, "SharePostId"))
        {
            sharepostId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];

            //((AjaxControlToolkit.ModalPopupExtender)(ListView1.FindControl("MPEShare"))).Show();
            MPEShare.Show();

        }
        if (String.Equals(e.CommandName, "Updatepost"))
        {
            Label lbl = ListView1.EditItem.FindControl("PostIdLabel") as Label;
            if (lbl != null) postId_edit = new Guid(lbl.Text);

            TextBox txt = ListView1.EditItem.FindControl("PostTextBox") as TextBox;
            String edit_text = txt.Text;



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE [UserPosts] SET [Post] = @Post WHERE [PostId] = @PostId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@Post", edit_text);
                myCommand.Parameters.AddWithValue("@PostId", postId_edit);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            ListView1.EditIndex = -1;
            Button btnCancel = (ListView1.Items[e.Item.DataItemIndex].FindControl("CancelButton")) as Button;
            //Button btnCancel=   ListView1.EditItem.FindControl("CancelButton") as Button;
            //CancelButton_Click(btnCancel, EventArgs.Empty);
            //btnCancel.Visible = true;
            //Type t = typeof(Button);
            //object[] p = new object[1];
            //p[0] = EventArgs.Empty;
            //MethodInfo m = t.GetMethod("OnClick", BindingFlags.NonPublic | BindingFlags.Instance);
            //m.Invoke(btnCancel, p);

            ListView1.DataBind();
        }
        if (String.Equals(e.CommandName, "Deletepost"))
        {
            ListView lv = (ListView)sender;
            Guid post_Id = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            string ctype = lv.DataKeys[e.Item.DataItemIndex].Values[3].ToString();


            if (ctype.Contains("image") || ctype.Contains("link") || ctype.Contains("post"))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string Sql = "delete from [PhotoStore] WHERE [PhotoID]=@PhotoID and UserId=@UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                    myCommand.Parameters.AddWithValue("@PhotoID", post_Id);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            if (ctype.Contains("video"))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string Sql = "delete from [VideoStore] WHERE [VideoID]=@VideoID and UserId=@UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                    myCommand.Parameters.AddWithValue("@VideoID", post_Id);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }

            lv.DataBind();
            UpdatePanel1.Update();
        }
        this.DataBind();
    }




    //protected void btnPostComment_Click1(object sender, EventArgs e)
    //{
    //    Button btn = sender as Button;
    //    tb = btn.FindControl("txtNewComment") as TextBox;

    //    //if (tb != null)
    //    //{
    //    //    ctext = tb.Text;

    //    //}
    //}
    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        //ListViewDataItem currentItem = (ListViewDataItem)e.Item;
        //Label postvalue = (Label)currentItem.FindControl("PostIdLabel");
        try
        {
            postId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String userId = currentUserId.ToString();

            ImageButton lb = e.Item.FindControl("LinkButtonLike") as ImageButton;
            LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;



            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeId);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }



        }
        catch { }
    }
    protected void lvMediaComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);

        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;

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
        this.DataBind();
    }
    protected void ListView2_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey = new Guid(((Label)lvi.FindControl("PostIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PostId", postKey);



            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);



            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }
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
        e.Cancel = true;
        this.DataBind();

    }
    protected void CommentsDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {


    }
    protected void UserProfileDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = currentUserId;

        }
    }
    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        ListView lv = ListView1.FindControl("ListView2") as ListView;

        MembershipUser currentUser = Membership.GetUser();
        if (e.Item.ItemType == ListViewItemType.InsertItem)
        {
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                Image lvd = e.Item.FindControl("ImageComment") as Image;
                lvd.ImageUrl = "ThumbnailHandlerPost.ashx?userid=" + currentUserId;

            }
        }

    }
    protected void ListView2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postIdc = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userIdc = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            LinkButton lb = e.Item.FindControl("LinkButtonLike") as LinkButton;



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
    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
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
    protected void ImageButtonGrid_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/home_m.aspx?un="+user_name);
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/home-list_m.aspx?un="+user_name);
    }
    protected void PostsDataSource1_Selecting1(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@my_id"].Value = currentUserId;
            e.Command.Parameters["@me"].Value = currentUserId;
        }
    }

    protected void btnShare_Click(object sender, EventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            //if (txtNewPost.Text != string.Empty)
            //{
            string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO SharePosts(PostId, ShareTo, ShareUser, Privacy,ShareText) VALUES(@PostId, @ShareTo, @ShareUser, @Privacy,@ShareText)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@PostId", sharepostId);
                myCommand.Parameters.AddWithValue("@ShareUser", HttpContext.Current.Session["user"]);
                myCommand.Parameters.AddWithValue("@ShareText", txtShareText.Text);
                myCommand.Parameters.AddWithValue("@Privacy", DBNull.Value);
                if (ddlShareTo.SelectedIndex == 0)
                {
                    txtFriendsName.Visible = false;

                    myCommand.Parameters.AddWithValue("@ShareTo", currentUserId);
                }
                if (ddlShareTo.SelectedIndex == 1)
                {

                    myCommand.Parameters.AddWithValue("@ShareTo", new Guid(txtFriendsID.Text));
                    string connectionString12 =
                              ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                    string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo,PostId) VALUES(@UserId,@Type,@NotifyTo,@PostId)";

                    using (SqlConnection myConnection2 = new SqlConnection(connectionString12))
                    {
                        myConnection2.Open();
                        SqlCommand myCommand2 = new SqlCommand(insertSql2, myConnection2);

                        myCommand2.Parameters.AddWithValue("@Type", "Share_Post");
                        myCommand2.Parameters.AddWithValue("@UserId", currentUserId);
                        myCommand2.Parameters.AddWithValue("@NotifyTo", new Guid(txtFriendsID.Text));
                    
                        myCommand.Parameters.AddWithValue("@PostId", sharepostId);
                        myCommand2.ExecuteNonQuery();
                        myConnection2.Close();

                    }
                }


                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            txtNewPost.Text = string.Empty;
            // }
        }
        ListView1.DataBind();
    }


    protected void ddlShareTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlShareTo.SelectedIndex == 0)
        {
            txtFriendsName.Visible = false;
            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                shareuserId = (Guid)currentUser.ProviderUserKey;

            }
        }
        if (ddlShareTo.SelectedIndex == 1)
        {
            txtFriendsName.Visible = true;
            if (string.IsNullOrEmpty(txtFriendsID.Text))
            {
                shareuserId = System.Guid.Empty;
            }
            else
            {
                shareuserId = new Guid(txtFriendsID.Text);
            }

        }
    }
    protected void ddlShareTo_TextChanged(object sender, EventArgs e)
    {
        if (ddlShareTo.Text == "On my timeline")
        {
            txtFriendsName.Visible = false;
            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                shareuserId = (Guid)currentUser.ProviderUserKey;

            }
        }
        if (ddlShareTo.Text == "On a friends timeline")
        {
            txtFriendsName.Visible = true;
            if (string.IsNullOrEmpty(txtFriendsID.Text))
            {
                shareuserId = System.Guid.Empty;
            }
            else
            {
                shareuserId = new Guid(txtFriendsID.Text);
            }


        }
    }
    protected void btnPhoto_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/photos.aspx?un=" + user_name);
    }
    protected void btnCircleCreate_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtNewCircle.Text))
            {
                string connectionString4 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql3 = "INSERT INTO UserCircles(Name, UserId) VALUES(@Name, @UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString4))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@Name", txtNewCircle.Text);

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                this.DataBind();
            }
        }
        catch { }
    }
    protected void circlemoreDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (DropDownList1.SelectedIndex == 0)
    //    {
    //        MenuSub.Items.Clear();
    //        MenuSub.Items.Add(new MenuItem("All"));
    //        MenuSub.Items.Add(new MenuItem("Friends"));
    //        MenuSub.Items.Add(new MenuItem("Family"));
    //        MenuSub.Items.Add(new MenuItem("Acquaintance"));
    //        MenuSub.Items.Add(new MenuItem("More..."));
    //        MenuSub.Items.Add(new MenuItem("+"));


    //    }
    //    if (DropDownList1.SelectedIndex == 1)
    //    {
    //        MenuSub.Items.Clear();
    //        MenuSub.Items.Add(new MenuItem("All"));
    //        MenuSub.Items.Add(new MenuItem("Friends"));
    //        MenuSub.Items.Add(new MenuItem("Family"));
    //        MenuSub.Items.Add(new MenuItem("Acquaintance"));
    //        MenuSub.Items.Add(new MenuItem("More..."));
    //        MenuSub.Items.Add(new MenuItem("+"));


    //    }
    //    if (DropDownList1.SelectedIndex == 2)
    //    {
    //        MenuSub.Items.Clear();
    //        MenuSub.Items.Add(new MenuItem("All"));
    //        MenuSub.Items.Add(new MenuItem("Personal"));
    //        MenuSub.Items.Add(new MenuItem("Entertainment"));
    //        MenuSub.Items.Add(new MenuItem("Company"));
    //        MenuSub.Items.Add(new MenuItem("More..."));
    //        MenuSub.Items.Add(new MenuItem("+"));


    //    }
    //    if (DropDownList1.SelectedIndex == 3)
    //    {
    //        MenuSub.Items.Clear();
    //        MenuSub.Items.Add(new MenuItem("All"));
    //        MenuSub.Items.Add(new MenuItem("Personal"));
    //        MenuSub.Items.Add(new MenuItem("Entertainment"));
    //        MenuSub.Items.Add(new MenuItem("Company"));
    //        MenuSub.Items.Add(new MenuItem("More..."));
    //        MenuSub.Items.Add(new MenuItem("+"));


    //    }
    //}
    protected void lstCircleMore_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "morecircle"))
        {
            Button btncircle = e.Item.FindControl("ButtonLabel") as Button;
            Response.Redirect("~/circleposts.aspx?cname=" + btncircle.Text);

        }
    }
    protected void MenuSub_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text == "+")
        {
            MPEAddCircle.Show();
        }
        if (e.Item.Text == "More...")
        {
            MPECircleMore.Show();

            //DDE.TargetControlID = e.Item.ToString();
        }
        if (e.Item.Text == "Close Friends")
        {
            Response.Redirect("~/circleposts.aspx?cname=Close Friends");
        }
        if (e.Item.Text == "Family")
        {
            Response.Redirect("~/circleposts.aspx?cname=Family");
        }
        if (e.Item.Text == "Acquaintances")
        {
            Response.Redirect("~/circleposts.aspx?cname=Acquaintances");
        }
    }
    protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        byte[] image = e.GetContents();

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


        }
        this.DataBind();
        e.DeleteTemporaryData();
    }
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void btnFriend_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/friends.aspx?un=" + user_name);
    }
    protected void LoadMore_Click(object sender, EventArgs e)
    {
        this.PostsDataSource1.SelectParameters["TopVal"].DefaultValue = (int.Parse(this.PostsDataSource1.SelectParameters["TopVal"].DefaultValue) + 4).ToString();
    }
    protected void btnVideo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/videos.aspx?un=" + user_name);
    }
   
    protected void btnAbout_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/about.aspx?un=" + user_name);
    }
    protected void AsyncFileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //string savePath = MapPath("~/uploads/" + System.IO.Path.GetFileName(e.FileName));
        //string imgPath = "uploads/" + e.FileName;         
        //AsyncFileUpload1.SaveAs(savePath);
        //if (AsyncFileUpload1.PostedFile != null)
        //{
        //    filep = AsyncFileUpload1.PostedFile;

        //    data = ReadFile(filep);
        //    //Store the image in the session.
        //    //Session["STORED_IMAGE"] = data;
        //}
        //var a=  AsyncFileUpload1.UniqueID;

        // Image img = new Image();
        // img.ImageUrl = "/" + imgPath;
        // img.BorderWidth = 3;
        // img.BorderColor = System.Drawing.Color.SaddleBrown;
        // PlaceHolder1.Controls.Add(img);

        //UpdatePanel4.Update();
    }
    protected void AsyncFileUpload2_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //if (AsyncFileUpload2.PostedFile != null)
        //{
        //    filep = AsyncFileUpload2.PostedFile;

        //    data = ReadFile(filep);
        //    //Store the image in the session.
        //    //Session["STORED_IMAGE"] = data;
        //}

    }
    private byte[] ReadFile(HttpPostedFile file)
    {
        byte[] data = new Byte[file.ContentLength];
        file.InputStream.Read(data, 0, file.ContentLength);
        return data;
    }
    protected void ListViewMediaComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postId2c = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId2c = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId2c = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            LinkButton lb = e.Item.FindControl("LinkButtonLike") as LinkButton;



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
        if ((e.Item != null) && (e.Item.ItemType == ListViewItemType.InsertItem))
        {
            ImageButton imgin = e.Item.FindControl("ImageProfile5") as ImageButton;
            imgin.ImageUrl = "ThumbnailHandlerPost.ashx?userid=" + currentUserId;

        }
    }
    protected void MediaCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;
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
            string post_userId = e.CommandArgument.ToString();

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


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo,PostId) VALUES(@UserId,@LikeId,@Type,@NotifyTo,PostId)";

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
    protected void ListView3_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        Panel lvii = (Panel)lvi.Parent;
        string post_userId = ((Label)lvii.FindControl("UserIdLabel")).Text;
        postKey = new Guid(((Label)lvii.FindControl("PostIdLabel")).Text);




        //   Guid postKey3 = (Guid)lvi.DataKeys[e.Item.DataItemIndex].Values[0];
        //string   post_userId = ( ((Label)ListView2.FindControl("UserIdLabel")).Text);


        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PostId", postKey);

            myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);

            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);



            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }
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

        e.Cancel = true;
        this.DataBind();
    }
    protected void btnVideo_Click1(object sender, EventArgs e)
    {

    }
}