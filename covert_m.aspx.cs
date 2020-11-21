using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    public Guid covertId, covertId2, postId_edit, covertIdmedia;
    public Guid covertKey, covertKey2;
    Label covertlbl;
    Guid currentUserId;
    static String category = "All";
    String likeId, likeIdc, likeId2, likeId2c;
    static int topselval = 0; static int topselval2 = 0;
    static HttpPostedFile filep;
    static byte[] data, data2;
    string user_name;
    Guid user_id;
    object AlbumID; object my_album_id, my_vidalbum_id;
    Guid comment_select;
   static string privacy = "on";
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
        ImageButton2.ImageUrl = "ThumbnailHandlerPost.ashx?userid=" + currentUserId;
        ImageProfile.ImageUrl = "ThumbnailHandlerProfile.ashx?userid=" + currentUserId;
        string connectionString3 =
         ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string selectSql2 = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

        using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
        {
            myConnection2.Open();
            SqlCommand myCommand2 = new SqlCommand(selectSql2, myConnection2);
            myCommand2.Parameters.AddWithValue("@UserId", user_id);
            myCommand2.Parameters.AddWithValue("@Name", "CovertPhotos");

            my_album_id = myCommand2.ExecuteScalar();
            myConnection2.Close();
        }
        string connectionString4 =
        ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string selectSql3 = "SELECT ID FROM VideoAlbums WHERE UserId=@UserId AND Name=@Name";

        using (SqlConnection myConnection2 = new SqlConnection(connectionString4))
        {
            myConnection2.Open();
            SqlCommand myCommand2 = new SqlCommand(selectSql3, myConnection2);
            myCommand2.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand2.Parameters.AddWithValue("@Name", "CovertVideos");

            my_vidalbum_id = myCommand2.ExecuteScalar();
            myConnection2.Close();
        }
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
                string insertSql2 = "INSERT INTO PhotoStore(PostUserId,Post,UserId,UserName,UserFullName,ContentType,PostType,Category,Avatar,Privacy) VALUES(@PostUserId,@Post,@UserId,@UserName,@UserFullName,@ContentType,@PostType,@Category,@Avatar,@Privacy)";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@Post", txtNewPost.Text);
                    myCommand3.Parameters.AddWithValue("@UserId", user_id);
                    myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                    myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand3.Parameters.AddWithValue("@UserFullName", txtPostedby.Text);
                    myCommand3.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                    myCommand3.Parameters.AddWithValue("@Privacy", privacy);
                    myCommand3.Parameters.AddWithValue("@ContentType", "post");
                    myCommand3.Parameters.AddWithValue("@PostType", "covert");

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


                    if (txtPostedby.Text == "anonymous")
                    {
                        byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + "images\\logo_covert.png");
                        myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                    }
                    else if (txtPostedby.Text == HttpContext.Current.Session["user"].ToString())
                    {
                        System.Data.SqlClient.SqlDataReader rdr = null;
                        System.Data.SqlClient.SqlConnection conn = null;
                        System.Data.SqlClient.SqlCommand sqlcmd = null;

                        try
                        {
                            string connectionString2 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                            conn = new System.Data.SqlClient.SqlConnection(connectionString2);

                            sqlcmd = new System.Data.SqlClient.SqlCommand("select ProfilePicture from UserProfiles where UserId='" + currentUserId + "'", conn);
                            conn.Open();
                            rdr = sqlcmd.ExecuteReader();
                            while (rdr.Read())
                            {

                                byte[] bytes = ((byte[])rdr["ProfilePicture"]);
                                myCommand3.Parameters.AddWithValue("@Avatar", bytes);

                            }
                            if (rdr != null)
                                rdr.Close();
                        }
                        catch { }


                        finally
                        {
                            if (conn != null)
                                conn.Close();
                        }


                    }
                    else
                    {
                        byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + ImageButton4.ImageUrl.Replace("~/", ""));
                        myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                    }
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
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
                        myCommand2.Parameters.AddWithValue("@Name", "CovertPhotos");

                        AlbumID = myCommand2.ExecuteScalar();
                        myConnection2.Close();
                    }

                    string connectionString2 =
                    ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string insertSql2 = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,UserFullName,ContentType,Description,PostType,Category,Avatar,Privacy) VALUES(@PostUserId,@ID,@UserId,@UserName,@UserFullName,@ContentType,@Description,@PostType,@Category,@Avatar,@Privacy)";

                    using (SqlConnection myConnection3 = new SqlConnection(connectionString2))
                    {
                        myConnection3.Open();
                        SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                        myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                        myCommand3.Parameters.AddWithValue("@UserId", user_id);
                        myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                        myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                        myCommand3.Parameters.AddWithValue("@UserFullName", txtPostedby.Text);
                        myCommand3.Parameters.AddWithValue("@Description", txtPhotoPost.Text.Trim());
                        myCommand3.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "image");
                        myCommand3.Parameters.AddWithValue("@PostType", "covert");
                        myCommand3.Parameters.AddWithValue("@Privacy", privacy);

                        if (txtPostedby.Text == "anonymous")
                        {
                            byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + "images\\logo_covert.png");
                            myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                        }
                        else if (txtPostedby.Text == HttpContext.Current.Session["user"].ToString())
                        {
                            System.Data.SqlClient.SqlDataReader rdr = null;
                            System.Data.SqlClient.SqlConnection conn = null;
                            System.Data.SqlClient.SqlCommand sqlcmd = null;

                            try
                            {
                                string connectionString24 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                                conn = new System.Data.SqlClient.SqlConnection(connectionString24);

                                sqlcmd = new System.Data.SqlClient.SqlCommand("select ProfilePicture from UserProfiles where UserId='" + currentUserId + "'", conn);
                                conn.Open();
                                rdr = sqlcmd.ExecuteReader();
                                while (rdr.Read())
                                {

                                    byte[] bytes = ((byte[])rdr["ProfilePicture"]);
                                    myCommand3.Parameters.AddWithValue("@Avatar", bytes);

                                }
                                if (rdr != null)
                                    rdr.Close();
                            }
                            catch { }


                            finally
                            {
                                if (conn != null)
                                    conn.Close();
                            }


                        }
                        else
                        {
                            byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + ImageButton4.ImageUrl.Replace("~/", ""));
                            myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                        }

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

                            imgurl = "/uploads/" + user_name + "/photos/covert/" + post__id + "." + files_types.Split('/').Last();
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
                        myCommand2.Parameters.AddWithValue("@Name", "CovertVideos");

                        AlbumID = myCommand2.ExecuteScalar();
                        myConnection2.Close();
                    }

                    string connectionString27 =
                    ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string insertSql2 = " INSERT INTO VideoStore(PostUserId,ID,UserId,UserName,ContentType,UserFullName,Description,PostType,Category,Avatar,Privacy) VALUES(@PostUserId,@ID,@UserId,@UserName,@ContentType,@UserFullName,@Description,@PostType,@Category,@Avatar,@Privacy)";

                    using (SqlConnection myConnection3 = new SqlConnection(connectionString27))
                    {
                        myConnection3.Open();
                        SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                        myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                        myCommand3.Parameters.AddWithValue("@UserId", user_id);
                        myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                        myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                        myCommand3.Parameters.AddWithValue("@UserFullName", txtPostedby.Text);
                        myCommand3.Parameters.AddWithValue("@Description", txtVideoPost.Text.Trim());
                        myCommand3.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "video");
                        myCommand3.Parameters.AddWithValue("@PostType", "covert");
                        myCommand3.Parameters.AddWithValue("@Privacy", privacy);
                        if (txtPostedby.Text == "anonymous")
                        {
                            byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + "images\\logo_covert.png");
                            myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                        }
                        else if (txtPostedby.Text == HttpContext.Current.Session["user"].ToString())
                        {
                            System.Data.SqlClient.SqlDataReader rdr = null;
                            System.Data.SqlClient.SqlConnection conn = null;
                            System.Data.SqlClient.SqlCommand sqlcmd = null;

                            try
                            {
                                string connectionString24 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                                conn = new System.Data.SqlClient.SqlConnection(connectionString24);

                                sqlcmd = new System.Data.SqlClient.SqlCommand("select ProfilePicture from UserProfiles where UserId='" + currentUserId + "'", conn);
                                conn.Open();
                                rdr = sqlcmd.ExecuteReader();
                                while (rdr.Read())
                                {

                                    byte[] bytes = ((byte[])rdr["ProfilePicture"]);
                                    myCommand3.Parameters.AddWithValue("@Avatar", bytes);

                                }
                                if (rdr != null)
                                    rdr.Close();
                            }
                            catch { }


                            finally
                            {
                                if (conn != null)
                                    conn.Close();
                            }


                        }
                        else
                        {
                            byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + ImageButton4.ImageUrl.Replace("~/", ""));
                            myCommand3.Parameters.AddWithValue("@Avatar", bytes);
                        }

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
                        imgurl = "/uploads/" + user_name + "/videos/covert/" + post__id + "." + files_types.Split('/').Last();
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
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>ClearPostBox();</script>", false);

        ListView1.DataBind();
        ListView3.DataBind();
        if (i != 0)
        {

            UpdatePanel2.Update();
        }
        else
        {
            UpdatePanel1.Update();
        }

    }


    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        //String query = "home-list.aspx";
        //String newWin = "window.open('" + query + "');";
        //ClientScript.RegisterStartupScript(GetType(), "OpenWindow", newWin, true);
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            txtPostedby.Text = HttpContext.Current.Session["user"].ToString();
        }
        privacy = "off";
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        txtPostedby.Text = "anonymous";
        privacy = "on";
    }

    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            covertId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Value;
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            comment_select = covertId;
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
        //HtmlTableCell tdPwdData = (HtmlTableCell)e.Item.FindControl("tdPwd");
        //Label lbl = tdPwdData.FindControl("CovertIdLabel") as Label;
        //string s = lbl.Text;

        //ListViewDataItem ItemToDisplay = (ListViewDataItem)e.Item;
        //covertId = new Guid(DataBinder.Eval(ItemToDisplay.DataItem, "CovertId").ToString());
        //ListViewItem item = (ListViewItem)ListView1.Items[e.Item.DataItemIndex];
        //Label l = (Label)item.FindControl("CovertIdLabel");


    }
    protected void CovertCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@CovertId"].Value = covertId;
    }
    protected void ListView2_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        covertKey = new Guid(((Label)lvi.FindControl("CovertIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;
        //txt = txtb.Text;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO CovertComments(Comment, CommentUser, CovertId,CommentUserId,CommentUserName) VALUES(@Comment, @CommentUser, @CovertId,@CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@CovertId", covertKey);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);
            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);



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

                myCommand.Parameters.AddWithValue("@Type", "Covert_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
         
                myCommand.Parameters.AddWithValue("@PostId", covertKey);
                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        e.Cancel = true;

        this.DataBind();
    }
    protected void ListView2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;

            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();


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
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        ListView lv = (ListView)sender;

      string pvc = lv.DataKeys[e.Item.DataItemIndex].Values[4].ToString();
        if (pvc=="off")
        {
            ((HyperLink)e.Item.FindControl("CovertPostUserLabel")).NavigateUrl = "~/index_m.aspx?un=" + ((Label)e.Item.FindControl("CovertPostUserName")).Text;

        }

        //System.Data.SqlClient.SqlDataReader rdr = null;
        //System.Data.SqlClient.SqlConnection conn = null;
        //System.Data.SqlClient.SqlCommand sqlcmd = null;

        //byte[] data = null;
        //try
        //{
        //    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //    conn = new System.Data.SqlClient.SqlConnection(connectionString);

        //    sqlcmd = new System.Data.SqlClient.SqlCommand("select CovertContent, CovertContentType from CovertPosts where CovertId='" + covertId + "'", conn);
        //    conn.Open();
        //    rdr = sqlcmd.ExecuteReader();
        //    while (rdr.Read())
        //    {
        //        //context.Response.ContentType = rdr["PostContentType"].ToString();
        //        data = ((byte[])rdr["CovertContent"]);

        //    }
        //    if (rdr != null)
        //        rdr.Close();
        //}
        //catch (Exception ex)
        //{

        //}

        //finally
        //{
        //    if (conn != null)
        //        conn.Close();
        //}

        //if (data != null && data.Length > 0)
        //{

        //    e.Item.FindControl("embed1").Visible = true;
        //}



    }
    protected void CovertIdLabel_Init(object sender, EventArgs e)
    {
        //covertlbl = (Label)sender;
        //string s = covertlbl.Text;
        //covertId = new Guid(covertlbl.Text);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtPostedby.Text = TextBox1.Text;
        privacy = "on";
    }

    //    protected void Image_Click(object sender, ImageClickEventArgs e)
    //    {
    //        ImageButton4.ImageUrl = ((ImageButton)sender).ImageUrl;
    //    }
    //    protected void RepeaterImages_ItemCommand(object source, RepeaterCommandEventArgs e)
    //    {
    //        ImageButton imgButton = (ImageButton)e.Item.FindControl("Image");
    //        string url = imgButton.ImageUrl;
    //    }
    //    protected void RepeaterImages_ItemCreated(object sender, RepeaterItemEventArgs e)
    //    {

    //        ImageButton imagelist = (ImageButton)e.Item.FindControl("Image");
    //if ( imagelist != null )
    //{

    //imagelist.Click += new System.Web.UI.ImageClickEventHandler(this.imagelist_Click);
    //}
    //    }
    //    private void imagelist_Click(object sender, System.EventArgs e)
    //    {
    //        ImageButton imagelist = (ImageButton)sender;
    //        string imagesource = imagelist.ImageUrl;
    //        // do whatever ... change your big image and so on
    //    }
    protected void Image_Click1(object sender, ImageClickEventArgs e)
    {
        ImageButton4.ImageUrl = ((ImageButton)sender).ImageUrl;
        ModalPopupExtender1.Show();
    }
    protected void btnChange_Click(object sender, EventArgs e)
    {


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
    protected void ImageButtonGrid_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/covert_m.aspx?un="+user_name);
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/covert-list_m.aspx?un="+user_name);
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedIndex == 0)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Today"));
            MenuSub.Items.Add(new MenuItem("Yesterday"));
            MenuSub.Items.Add(new MenuItem("More..."));




        }
        if (DropDownList1.SelectedIndex == 1)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All Time"));
            MenuSub.Items.Add(new MenuItem("Today"));
            MenuSub.Items.Add(new MenuItem("Monthly"));
            MenuSub.Items.Add(new MenuItem("Yearly"));
            MenuSub.Items.Add(new MenuItem("More..."));
            Response.Redirect("~/covert-list_top10.aspx");



        }
        if (DropDownList1.SelectedIndex == 2)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Today"));
            MenuSub.Items.Add(new MenuItem("Yesterday"));
            MenuSub.Items.Add(new MenuItem("More..."));


        }
        if (DropDownList1.SelectedIndex == 3)
        {
            MenuSub.Items.Clear();
            MenuSub.Items.Add(new MenuItem("All"));
            MenuSub.Items.Add(new MenuItem("Today"));
            MenuSub.Items.Add(new MenuItem("Yesterday"));
            MenuSub.Items.Add(new MenuItem("More..."));
            Response.Redirect("~/covert-list_bookmark.aspx");


        }
    }
    protected void MediaDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = comment_select;
    }

    protected void lvMediaComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        Guid photo_id = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);

        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PhotoID", photo_id);


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
                    myCommand.Parameters.AddWithValue("@PostId", photo_id);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }

            }
        }
        catch { }

        e.Cancel = true;
        this.DataBind();
    }
    protected void btnRomantic_Click(object sender, EventArgs e)
    {
        category = "Romantic";
        this.DataBind();
    }
    protected void btnReligious_Click(object sender, EventArgs e)
    {
        category = "Religious";
        this.DataBind();
    }
    protected void btnPatriotic_Click(object sender, EventArgs e)
    {
        category = "Patriotic";
        this.DataBind();
    }
    protected void btnEducational_Click(object sender, EventArgs e)
    {
        category = "Educational";
        this.DataBind();
    }
    protected void btnExperience_Click(object sender, EventArgs e)
    {
        category = "Experience";
        this.DataBind();
    }
    protected void btnTravel_Click(object sender, EventArgs e)
    {
        category = "Travel";
        this.DataBind();
    }
    protected void btnReview_Click(object sender, EventArgs e)
    {
        category = "Review";
        this.DataBind();
    }
    protected void CovertDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        topselval += 4;
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            if (category == "All")
            {

                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType='post' and [PostType]='covert') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType='post' and [PostType]='covert'))  order by [Date] desc";
                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));

                //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
                //e.Command.Parameters["@Category"].Value = category;


            }

            else
            {
                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType='post' and [PostType]='covert' and Category=@Category ) UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType='post' and [PostType]='covert' and Category=@Category))  order by [Date] desc";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", category));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
            }
        }
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "Bookmarkpost"))
        {
            Guid post_Id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];

            System.Data.SqlClient.SqlDataReader rdr = null; System.Data.SqlClient.SqlConnection conn = null; System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [CovertBookmark]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                //if (rdr.HasRows)
                //{
                while (rdr.Read())
                {
                    String covertid = rdr["ID"].ToString();
                    String userid = rdr["UserId"].ToString();
                    if (covertid == post_Id.ToString() && userid == currentUserId.ToString())
                    {
                        string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
                        string Sql = "delete from [CovertBookmark] WHERE ID=@ID and UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(connectionString10))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                            myCommand.Parameters.AddWithValue("@ID", new Guid(covertid));
                            myCommand.Parameters.AddWithValue("@UserId", new Guid(userid));

                            myCommand.ExecuteNonQuery();

                            myConnection.Close();

                        }
                        return;
                        //rdr.NextResult();
                    }

                }
                string connectionString2 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string Sql2 = "INSERT INTO CovertBookmark(ID,UserId) VALUES(@ID,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql2, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", post_Id);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);

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



            //ListView2.DataBind();
            //UpdatePanel1.Update();

        }
        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;

            String like_Id = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            String post_userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
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
                        myCommand.Parameters.AddWithValue("@Type", "Covert_Post_Like");
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
        if (String.Equals(e.CommandName, "Updatepost"))
        {
            Label lbl = ListView1.EditItem.FindControl("CovertIdLabel") as Label;
            if (lbl != null) postId_edit = new Guid(lbl.Text);

            TextBox txt = ListView1.EditItem.FindControl("CovertPostTextBox") as TextBox;
            String edit_text = txt.Text;

            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE [CovertPosts] SET [CovertPost] = @CovertPost WHERE [CovertId] = @CovertId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@CovertPost", edit_text);
                myCommand.Parameters.AddWithValue("@CovertId", postId_edit);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            ListView1.EditIndex = -1;
            //Button btnCancel = (ListView1.Items[e.Item.DataItemIndex].FindControl("CancelButton")) as Button;


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
    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "Bookmarkpost"))
        {
            Guid post_Id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];

            System.Data.SqlClient.SqlDataReader rdr = null; System.Data.SqlClient.SqlConnection conn = null; System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [CovertBookmark]", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                //if (rdr.HasRows)
                //{
                while (rdr.Read())
                {
                    String covertid = rdr["ID"].ToString();
                    String userid = rdr["UserId"].ToString();
                    if (covertid == post_Id.ToString() && userid == currentUserId.ToString())
                    {
                        string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
                        string Sql = "delete from [CovertBookmark] WHERE ID=@ID and UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(connectionString10))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                            myCommand.Parameters.AddWithValue("@ID", new Guid(covertid));
                            myCommand.Parameters.AddWithValue("@UserId", new Guid(userid));

                            myCommand.ExecuteNonQuery();

                            myConnection.Close();

                        }
                        return;
                        //rdr.NextResult();
                    }

                }
                string connectionString2 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string Sql2 = "INSERT INTO CovertBookmark(ID,UserId) VALUES(@ID,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql2, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", post_Id);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);

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



            //ListView2.DataBind();
            //UpdatePanel1.Update();

        }
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            String like_Id = likeidlbl.Text;

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
                        myCommand.Parameters.AddWithValue("@Type", "Covert_Comment_Like");
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
    protected void ListView3_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            covertId2 = (Guid)ListView3.DataKeys[e.Item.DataItemIndex].Value;
            likeId = ListView3.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            comment_select = covertId2;
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
    protected void ListView3_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        System.Web.UI.HtmlControls.HtmlAnchor hlp = e.Item.FindControl("photo_popup") as System.Web.UI.HtmlControls.HtmlAnchor;
        Control popdiv = e.Item.FindControl("inline_content") as Control;
        hlp.HRef = "#" + popdiv.ClientID;
        if (((HyperLink)e.Item.FindControl("CovertPostUserLabel")).Text != "anonymous")
        {
            ((HyperLink)e.Item.FindControl("CovertPostUserLabel")).NavigateUrl = "~/index_m.aspx?un=" + ((Label)e.Item.FindControl("CovertPostUserName")).Text;

        }
        covertIdmedia = (Guid)ListView3.DataKeys[e.Item.DataItemIndex].Value;
        ListView lv = (ListView)sender;
        string mediatype = lv.DataKeys[e.Item.DataItemIndex].Values[3].ToString();
        
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

           

        }
        catch { }
    }
    protected void ListView3_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;

            String like_Id = ListView3.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            String post_userId = ListView3.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
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
                        myCommand.Parameters.AddWithValue("@Type", "Covert_Post_Like");
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
        if (String.Equals(e.CommandName, "Updatepost"))
        {
            Label lbl = ListView3.EditItem.FindControl("CovertIdLabel") as Label;
            if (lbl != null) postId_edit = new Guid(lbl.Text);

            TextBox txt = ListView3.EditItem.FindControl("CovertPostTextBox") as TextBox;
            String edit_text = txt.Text;

            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE [CovertPosts] SET [CovertPost] = @CovertPost WHERE [CovertId] = @CovertId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@CovertPost", edit_text);
                myCommand.Parameters.AddWithValue("@CovertId", postId_edit);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            ListView3.EditIndex = -1;
            //Button btnCancel = (ListView1.Items[e.Item.DataItemIndex].FindControl("CancelButton")) as Button;


            ListView3.DataBind();
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
            UpdatePanel2.Update();
        }
        this.DataBind();
    }
    protected void ListView4_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        covertKey2 = new Guid(((Label)lvi.FindControl("CovertIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;
        //txt = txtb.Text;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO CovertComments(Comment, CommentUser, CovertId,CommentUserId,CommentUserName) VALUES(@Comment, @CommentUser, @CovertId,@CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@CovertId", covertKey2);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);
            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);



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

                myCommand.Parameters.AddWithValue("@Type", "Covert_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
          
                myCommand.Parameters.AddWithValue("@PostId", covertKey2);
                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        e.Cancel = true;

        this.DataBind();
    }
    protected void ListView4_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;

            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();


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
    protected void ListView4_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            String like_Id = likeidlbl.Text;

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
                        myCommand.Parameters.AddWithValue("@Type", "Covert_Comment_Like");
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
    protected void CovertMediaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        topselval2 += 4;
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            if (category == "All")
            {

                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType !='post' and [PostType]='covert') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType !='post' and [PostType]='covert'))  order by [Date] desc";
                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval2));
                //e.Command.Parameters.Add(new SqlParameter("@IDP", my_album_id));
                //e.Command.Parameters.Add(new SqlParameter("@IDV", my_vidalbum_id));

                //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
                //e.Command.Parameters["@Category"].Value = category;


            }

            else
            {
                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType !='post' and [PostType]='covert' and Category=@Category) UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType !='post' and [PostType]='covert' and Category=@Category))  order by [Date] desc";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", category));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval2));
            }
        }
    }
    protected void CovertMediaCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@CovertId"].Value = covertId2;
    }
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void LoadMore_Click(object sender, EventArgs e)
    {
        ListView1.DataBind();
        ListView3.DataBind();
    }
    protected void MenuSub_MenuItemClick(object sender, MenuEventArgs e)
    {
        string item = e.Item.Text;
        if (string.Equals(item, "All Time"))
        {
            Response.Redirect("~/covert_m.aspx");
        }
        else {
            Response.Redirect("~/covert-list_time.aspx?item=" + item);
        }
      
        
       
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
    protected void Button9_Click(object sender, EventArgs e)
    {

    }
    protected void Button9_Click1(object sender, EventArgs e)
    {
        category = "Others";
        this.DataBind();
    }
}