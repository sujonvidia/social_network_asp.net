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
    Guid raceId, raceIdc, raceId2c, postId_edit, raceIdmedia;
    Guid raceId2;
    Guid raceKey;
    Guid raceKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static String category = "All";
    Guid currentUserId;
    static int topselval = 0; static int topselval2 = 0;
    static HttpPostedFile filep;
    static byte[] data, data2;
    string user_name;
    Guid user_id;
    object AlbumID; object my_album_id, my_vidalbum_id;
    Guid comment_select;
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
        //string connectionString3 =
        // ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //string selectSql2 = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

        //using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
        //{
        //    myConnection2.Open();
        //    SqlCommand myCommand2 = new SqlCommand(selectSql2, myConnection2);
        //    myCommand2.Parameters.AddWithValue("@UserId", user_id);
        //    myCommand2.Parameters.AddWithValue("@Name", "RacePhotos");

        //    my_album_id = myCommand2.ExecuteScalar();
        //    myConnection2.Close();
        //}
        //string connectionString4 =
        //ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //string selectSql3 = "SELECT ID FROM VideoAlbums WHERE UserId=@UserId AND Name=@Name";

        //using (SqlConnection myConnection2 = new SqlConnection(connectionString4))
        //{
        //    myConnection2.Open();
        //    SqlCommand myCommand2 = new SqlCommand(selectSql3, myConnection2);
        //    myCommand2.Parameters.AddWithValue("@UserId", currentUserId);
        //    myCommand2.Parameters.AddWithValue("@Name", "RaceVideos");

        //    my_vidalbum_id = myCommand2.ExecuteScalar();
        //    myConnection2.Close();
        //}
    }
    public static void SortListControl(ListControl control, bool isAscending)
    {
        List<ListItem> collection;

        if (isAscending)
            collection = control.Items.Cast<ListItem>()
                .Select(x => x)
                .OrderBy(x => x.Text)
                .ToList();
        else
            collection = control.Items.Cast<ListItem>()
                .Select(x => x)
                .OrderByDescending(x => x.Text)
                .ToList();

        control.Items.Clear();

        foreach (ListItem item in collection)
            control.Items.Add(item);
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
                string insertSql2 = "INSERT INTO PhotoStore(PostUserId,Post,UserId,UserName,UserFullName,ContentType,PostType,SubCategory) VALUES(@PostUserId,@Post,@UserId,@UserName,@UserFullName,@ContentType,@PostType,@SubCategory)";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(insertSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@Post", txtNewPost.Text);
                    myCommand3.Parameters.AddWithValue("@UserId", user_id);
                    myCommand3.Parameters.AddWithValue("@PostUserId", currentUserId);
                    myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand3.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand3.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
              
                    myCommand3.Parameters.AddWithValue("@ContentType", "post");
                    myCommand3.Parameters.AddWithValue("@PostType", "race");
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
                    string insertSql2 = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,UserFullName,ContentType,Description,PostType,SubCategory) VALUES(@PostUserId,@ID,@UserId,@UserName,@UserFullName,@ContentType,@Description,@PostType,@SubCategory)";

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
                        myCommand3.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "image");
                        myCommand3.Parameters.AddWithValue("@PostType", "race");



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
                    string insertSql2 = " INSERT INTO VideoStore(PostUserId,ID,UserId,UserName,ContentType,UserFullName,Description,PostType,SubCategory) VALUES(@PostUserId,@ID,@UserId,@UserName,@ContentType,@UserFullName,@Description,@PostType,@SubCategory)";

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
                        myCommand3.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
                        myCommand3.Parameters.AddWithValue("@ContentType", "video");
                        myCommand3.Parameters.AddWithValue("@PostType", "race");

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
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>ClearPostBox();</script>", false);

        ListView1.DataBind();
        ListView2.DataBind();
        if (i != 0)
        {

            UpdatePanel2.Update();
        }
        else
        {
            UpdatePanel1.Update();
        }

    }
    protected void RacePostDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        topselval += 4;
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            if (category == "All")
            {

                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType='post' and [PostType]='race') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType='post' and [PostType]='race'))  order by [Date] desc";

                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));

                //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
                //e.Command.Parameters["@Category"].Value = category;


            }
            else if (category.Contains("/"))
            {
                string[] cat = category.Split('/');
                e.Command.CommandText = "SELECT top(@TopVal) * FROM [RacePosts] WHERE (([RaceContentType] IS NULL) AND [Category]=@Category AND [SubCategory]=@SubCategory) ORDER BY [RacePostDate] DESC";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", cat[0]));
                e.Command.Parameters.Add(new SqlParameter("@SubCategory", cat[1]));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
            }
            else
            {
                e.Command.CommandText = "SELECT top(@TopVal) * FROM [RacePosts] WHERE (([RaceContentType] IS NULL) AND [Category]=@Category) ORDER BY [RacePostDate] DESC";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", category));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
            }
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

        TextBox txtb = (e.Item.FindControl("RaceCommentTextBox")) as TextBox;


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
    protected void RaceMediaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        topselval2 += 4;
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            if (category == "All")
            {

                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ( ContentType !='post' and [PostType]='race') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ( ContentType !='post' and [PostType]='race'))  order by [Date] desc";
                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval2));
                //e.Command.Parameters.Add(new SqlParameter("@IDP", my_album_id));
                //e.Command.Parameters.Add(new SqlParameter("@IDV", my_vidalbum_id));

                //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
                //e.Command.Parameters["@Category"].Value = category;


            }
            //else if (category.Contains("/"))
            //{
            //    string[] cat = category.Split('/');
            //    e.Command.CommandText = "SELECT top(@TopVal) * FROM [PhotoStore] WHERE ( [Category]=@Category AND [SubCategory]=@SubCategory) ORDER BY {Date] DESC";
            //    e.Command.Parameters.Clear();

            //    e.Command.Parameters.Add(new SqlParameter("@Category", cat[0]));
            //    e.Command.Parameters.Add(new SqlParameter("@SubCategory", cat[1]));
            //    e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval2));
            //}
            //else
            //{
            //    e.Command.CommandText = "SELECT top(@TopVal) * FROM [PhotoStore] WHERE ( [Category]=@Category) ORDER BY [Date] DESC";
            //    e.Command.Parameters.Clear();

            //    e.Command.Parameters.Add(new SqlParameter("@Category", category));
            //    e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval2));
            //}
        }

    }

    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {


            raceId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
            comment_select = raceId;

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;
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
    protected void RacePostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@RaceId"].Value = raceId;
    }
    protected void ListViewPostComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;


        Panel lvi = (Panel)lv.Parent;
      
        raceKey = new Guid(((Label)lvi.FindControl("RaceIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("RaceCommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO RaceComments(RaceComment, RaceId, RaceCommentUser,CommentUserId,RaceCommentUserName) VALUES(@RaceComment, @RaceId, @RaceCommentUser,@CommentUserId,@RaceCommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@RaceComment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@RaceId", raceKey);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);


            myCommand.Parameters.AddWithValue("@RaceCommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@RaceCommentUserName", User.Identity.Name);

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

                myCommand.Parameters.AddWithValue("@Type", "Race_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);

                myCommand.Parameters.AddWithValue("@PostId", raceKey);
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


            raceId2 = (Guid)ListView2.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId2 = ListView2.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId2 = ListView2.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
            comment_select = raceId2;

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;
            LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;



            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeId2);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }

        }
        catch { }
    }
    protected void RaceMediaCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@RaceId"].Value = raceId2;
    }
    protected void ListViewMediaComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        raceKey2 = new Guid(((Label)lvi.FindControl("RaceIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("RaceCommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO RaceComments(RaceComment, RaceId, RaceCommentUser,CommentUserId,RaceCommentUserName) VALUES(@RaceComment, @RaceId, @RaceCommentUser,@CommentUserId,@RaceCommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@RaceComment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@RaceId", raceKey2);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);
            myCommand.Parameters.AddWithValue("@RaceCommentUserName", User.Identity.Name);



            myCommand.Parameters.AddWithValue("@RaceCommentUser", HttpContext.Current.Session["user"]);

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

                myCommand.Parameters.AddWithValue("@Type", "Race_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);

                myCommand.Parameters.AddWithValue("@PostId", raceKey2);
                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        e.Cancel = true;
        this.DataBind();
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {

        if (String.Equals(e.CommandName, "profile_link"))
        {
            Response.Redirect("~/index_m.aspx?un=" + e.CommandArgument.ToString());
        }
        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            likeId_in = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[1];
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
                        myCommand.Parameters.AddWithValue("@Type", "Race_Post_Like");
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
            Label lbl = ListView1.EditItem.FindControl("RaceIdLabel") as Label;
            if (lbl != null) postId_edit = new Guid(lbl.Text);

            TextBox txt = ListView1.EditItem.FindControl("RacePostTextBox") as TextBox;
            String edit_text = txt.Text;



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE [RacePosts] SET [RacePost] = @RacePost WHERE [RaceId] = @RaceId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@RacePost", edit_text);
                myCommand.Parameters.AddWithValue("@RaceId", postId_edit);
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
    protected void ListViewPostComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            raceIdc = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
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
                        myCommand.Parameters.AddWithValue("@Type", "Race_Comment_Like");
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

    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            likeId_in = (Guid)ListView2.DataKeys[e.Item.DataItemIndex].Values[1];
            String like_Id = ListView2.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            String post_userId = ListView2.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

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
                        myCommand.Parameters.AddWithValue("@Type", "Race_Post_Like");
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
            Label lbl = ListView2.EditItem.FindControl("RaceIdLabel") as Label;
            if (lbl != null) postId_edit = new Guid(lbl.Text);

            TextBox txt = ListView2.EditItem.FindControl("RacePostTextBox") as TextBox;
            String edit_text = txt.Text;



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE [RacePosts] SET [RacePost] = @RacePost WHERE [RaceId] = @RaceId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@RacePost", edit_text);
                myCommand.Parameters.AddWithValue("@RaceId", postId_edit);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            ListView2.EditIndex = -1;
            //Button btnCancel = (ListView1.Items[e.Item.DataItemIndex].FindControl("CancelButton")) as Button;


            this.DataBind();
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
    protected void ListViewMediaComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            raceId2c = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId2c = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId2c = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;



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
    protected void ListViewMediaComment_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                        myCommand.Parameters.AddWithValue("@Type", "Race_Comment_Like");
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
        Response.Redirect("~/race_m.aspx?un="+user_name);
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/race-list_m.aspx?un="+user_name);
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


    protected void ddlCategory_TextChanged(object sender, EventArgs e)
    {
        if (ddlCategory.SelectedValue == "Art")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Paint"));
            ddlSubCategory.Items.Add(new ListItem("Graphics"));
            ddlSubCategory.Items.Add(new ListItem("Sketch"));

            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Business")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Idea"));
            ddlSubCategory.Items.Add(new ListItem("Vacancy"));
            ddlSubCategory.Items.Add(new ListItem("Job offer"));
            ddlSubCategory.Items.Add(new ListItem("Job application"));

            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Education")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Commerce"));
            ddlSubCategory.Items.Add(new ListItem("Science"));
            ddlSubCategory.Items.Add(new ListItem("Engineering"));
            ddlSubCategory.Items.Add(new ListItem("Arts"));
            ddlSubCategory.Items.Add(new ListItem("Humanities"));
            ddlSubCategory.Items.Add(new ListItem("School"));
            ddlSubCategory.Items.Add(new ListItem("College"));

            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Literature")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Poem"));
            ddlSubCategory.Items.Add(new ListItem("Stories"));
            ddlSubCategory.Items.Add(new ListItem("Novel"));

            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Music")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Alternative"));
            ddlSubCategory.Items.Add(new ListItem("Blues"));
            ddlSubCategory.Items.Add(new ListItem("Classical"));
            ddlSubCategory.Items.Add(new ListItem("Country"));
            ddlSubCategory.Items.Add(new ListItem("Dance"));
            ddlSubCategory.Items.Add(new ListItem("Electronic"));
            ddlSubCategory.Items.Add(new ListItem("Folk"));
            ddlSubCategory.Items.Add(new ListItem("Hip-Hop/Rap"));
            ddlSubCategory.Items.Add(new ListItem("Jazz"));
            ddlSubCategory.Items.Add(new ListItem("New Age"));
            ddlSubCategory.Items.Add(new ListItem("Opera"));
            ddlSubCategory.Items.Add(new ListItem("Pop"));
            ddlSubCategory.Items.Add(new ListItem("R&B/Soul"));
            ddlSubCategory.Items.Add(new ListItem("Reggae"));
            ddlSubCategory.Items.Add(new ListItem("Rock"));
            ddlSubCategory.Items.Add(new ListItem("Singer/Songwriter"));
            ddlSubCategory.Items.Add(new ListItem("World Music/Beats"));

            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Recreational")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Comic"));
            ddlSubCategory.Items.Add(new ListItem("Jokes"));
            ddlSubCategory.Items.Add(new ListItem("Trivia"));
            ddlSubCategory.Items.Add(new ListItem("Review"));


            SortListControl(ddlSubCategory, true);
        }
        if (ddlCategory.SelectedValue == "Video")
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Flim"));
            ddlSubCategory.Items.Add(new ListItem("Short Flim"));
            ddlSubCategory.Items.Add(new ListItem("Documentary"));
            ddlSubCategory.Items.Add(new ListItem("Trip"));


            SortListControl(ddlSubCategory, true);
        }
    }
    protected void MenuMain_MenuItemClick(object sender, MenuEventArgs e)
    {

        category = e.Item.ValuePath;

        //string connectionString =
        //               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


        //string insertSql = "SELECT * FROM [RacePosts] WHERE (([UserId] = @UserId) AND ([RaceContentType] IS NULL) AND [Category]=@Category) ORDER BY [RacePostDate] DESC";

        //        using (SqlConnection myConnection = new SqlConnection(connectionString))
        //        {
        //            myConnection.Open();
        //            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

        //            myCommand.Parameters.AddWithValue("@Category", e.Item.ToString());

        //            MembershipUser currentUser = Membership.GetUser();

        //            if (currentUser != null)
        //            {
        //                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        //                myCommand.Parameters.AddWithValue("@UserId", currentUserId);


        //            }

        //            myCommand.ExecuteNonQuery();
        //            myConnection.Close();

        //        }
        this.DataBind();
    }
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        HtmlButton htb = e.Item.FindControl("racepost") as HtmlButton;
        AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        trigger.ControlID = htb.UniqueID;
        UpdatePanel1.Triggers.Add(trigger);
        ScriptManager sm = this.Master.FindControl("MasterScriptManager") as ScriptManager;
        sm.RegisterAsyncPostBackControl(htb);

        // var span1 = e.Item.FindControl("racepost") as HtmlGenericControl;

        //Guid _raceId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
        //span1.ID = _raceId.ToString();
        //span1.Attributes["onclick"] = ClientScript.GetPostBackEventReference(this, "ClickRacePost");
    }
    protected void LoadMore_Click(object sender, EventArgs e)
    {
        ListView1.DataBind();
        ListView2.DataBind();
    }
    protected void racepost_ServerClick(object sender, EventArgs e)
    {
        HtmlButton button = sender as HtmlButton;

        string race_id = button.Attributes[("Value")];
        string title = button.Attributes[("Title")];
        string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO RacePoints(RaceId, MyId, Activity, SubCategory,Iweu) VALUES(@RaceId, @MyId, @Activity, @SubCategory,@Iweu)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@RaceId", new Guid(race_id));
            myCommand.Parameters.AddWithValue("@MyId", currentUserId);
            myCommand.Parameters.AddWithValue("@Activity", "View");
            myCommand.Parameters.AddWithValue("@SubCategory", title);
            myCommand.Parameters.AddWithValue("@Iweu", 2);
           

            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }
        //UpdatePanel1.Update();
        this.DataBind();
    }
    protected void btnMyIweu_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/myiweu.aspx?un=" + user_name);
    }
    protected void btnRankInfo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/rankinfo.aspx?un=" + user_name);
    }
    protected void btnPointCurrent_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PO_Current.aspx?un=" + user_name);
    }
    protected void btnPointAll_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PO_All.aspx?un=" + user_name);
    }
    protected void btnMyActivity_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/raceActivity.aspx?un=" + user_name);
    }
    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        System.Web.UI.HtmlControls.HtmlAnchor hlp = e.Item.FindControl("photo_popup") as System.Web.UI.HtmlControls.HtmlAnchor;
        Control popdiv = e.Item.FindControl("inline_content") as Control;
        hlp.HRef = "#" + popdiv.ClientID;
        ListView lv = (ListView)sender;
        string mediatype = lv.DataKeys[e.Item.DataItemIndex].Values[3].ToString();
        HtmlButton htb = e.Item.FindControl("racepost") as HtmlButton;
        AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        trigger.ControlID = htb.UniqueID;
        UpdatePanel2.Triggers.Add(trigger);
        ScriptManager sm = this.Master.FindControl("MasterScriptManager") as ScriptManager;
        sm.RegisterAsyncPostBackControl(htb);
        raceIdmedia = (Guid)ListView2.DataKeys[e.Item.DataItemIndex].Value;
   

       
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
    protected void MenuSub_MenuItemClick(object sender, MenuEventArgs e)
    {
        string item = e.Item.Text;
        if (string.Equals(item, "All Ranks"))
        {
            Response.Redirect("~/race_m.aspx?un=" + user_name);
        }
        else
        {
            //Response.Redirect("~/covert-list_time.aspx?item=" + item);
        }
    }
}