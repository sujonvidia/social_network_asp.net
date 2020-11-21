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
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    Guid postId, postIdc, postId2c, postId_edit;
    Guid postKey;
    Guid postId2;
    Guid postKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static Guid sharepostId, shareuserId;
    Guid currentUserId;
    public string item_id;
    object AlbumID;
    static byte[] data, data2;
    static HttpPostedFile filep;
    string user_name;
    Guid user_id;
    Guid comment_select, comment_select_profile, comment_select_cover;
    Guid profile_userid, profile_photoid, cover_userid, cover_photoid;
    static int topselval = 4; string postseltype = string.Empty;
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
        if (user_id.ToString() == currentUserId.ToString())
        {
            postBox.Visible = true;
            SendFriendReq.Text = "Update Info";
            pnlBtnReq.Visible = false;
            btnChangeBackground.Visible = true;
            UpdatePanel3.Visible = true;
            postseltype = "Self";
        }
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;


        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select [Request_from], [Request_to],[Request_status] from FriendRequests", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {
                //context.Response.ContentType = rdr["PostContentType"].ToString();
                string req_from = (rdr["Request_from"].ToString());
                string req_to = (rdr["Request_to"].ToString());
                int status = ((int)rdr["Request_status"]);

                if (req_from == currentUserId.ToString() && req_to == user_id.ToString() && status == 0)
                {
                    SendFriendReq.Text = "Request Pending";
                }
                if (req_from == currentUserId.ToString() && req_to == user_id.ToString() && status == 1)
                {
                    postBox.Visible = true;
                    SendFriendReq.Text = "Friends";
                    postseltype = "Friends";
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
    }
    protected void SendFriendReq_PreRender(object sender, EventArgs e)
    {

    }
    protected void pnlBtnReq_PreRender(object sender, EventArgs e)
    {
        if (SendFriendReq.Text == "Add Friend")
        {
            btnReq.Visible = false;
        }
        if (SendFriendReq.Text == "Request Pending")
        {
            btnReq.Visible = true;
            btnReq.Text = "Cancel Request";
            //
        }
        if (SendFriendReq.Text == "Friends")
        {
            btnReq.Visible = true;
            btnReq.Text = "Unfriend";
        }

    }
    protected void btnReq_Click(object sender, EventArgs e)
    {
        if (btnReq.Text == "Cancel Request")
        {
            string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string Sql = "delete from [FriendRequests] WHERE [Request_from]=@Request_from and [Request_to]=@Request_to";

            using (SqlConnection myConnection = new SqlConnection(connectionString10))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                myCommand.Parameters.AddWithValue("@Request_from", currentUserId);
                myCommand.Parameters.AddWithValue("@Request_to", user_id);

                myCommand.ExecuteNonQuery();

                myConnection.Close();

            }
            SendFriendReq.Text = "Add Friend";
        }
        if (btnReq.Text == "Unfriend")
        {
            string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string Sql = "delete from [FriendsList] WHERE [friend_id]=@friend_id and [my_id]=@my_id";

            using (SqlConnection myConnection = new SqlConnection(connectionString10))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                myCommand.Parameters.AddWithValue("@friend_id", user_id);
                myCommand.Parameters.AddWithValue("@my_id", currentUserId);

                myCommand.ExecuteNonQuery();

                myConnection.Close();

            }
            SendFriendReq.Text = "Add Friend";
        }
        this.DataBind();
    }
    protected void SendFriendReq_Click(object sender, EventArgs e)
    {
        if (SendFriendReq.Text == "Add Friend")
        {
            string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO FriendRequests(Request_from, Request_to) VALUES(@Request_from, @Request_to)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@Request_from", currentUserId);
                myCommand.Parameters.AddWithValue("@Request_to", user_id);


                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }
            SendFriendReq.Text = "Request Pending";
        }
        if (SendFriendReq.Text == "Friends") { }
        if (SendFriendReq.Text == "Update Info")
        {
         Response.Redirect("~/about.aspx?un=" + user_name); 
        }
        this.DataBind();
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

                    byte[] data = new byte[file.ContentLength];

                    file.InputStream.Read(data, 0, file.ContentLength);
                    myCommand.Parameters.AddWithValue("@ProfilePicture", data);
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
    protected void Button2_Click(object sender, EventArgs e)
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
    protected void ImageProfile_Click(object sender, ImageClickEventArgs e)
    {
        //Button btn = UserProfile.FindControl("Button1") as Button;

        //btn.Visible = true;

    }

    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {

          
            postId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
     

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
        catch { UpdatePanel1.Update(); }
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
        MediaDS.SelectCommand = "SELECT * FROM [PhotoComments] WHERE ([PhotoID] = '" + postKey + "') ORDER BY [CommentDate]";


        ListView4.DataBind();
    }
    protected void MediaDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = postId;
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

        postId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0]; 
        likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
        userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

        Button lb = e.Item.FindControl("LinkButtonLike") as Button;
        LinkButton lbviewallcomment = e.Item.FindControl("LinkViewAllComment") as LinkButton;
        Panel pp = e.Item.FindControl("items") as Panel;
        string yy = pp.ClientID;

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

        if (mediatype.Contains("video") || mediatype.Contains("image"))
        {
            try
            {
                
                //e.Item.FindControl("post_backcolor") as = "class-name";
                Panel myDiv = (Panel)e.Item.FindControl("post_backcolor");
                myDiv.Attributes.Add("style", "background-color:white;");
            }
            catch { }


        }
        //try
        //{
        //    if (e.Item.ItemType == ListViewItemType.DataItem)
        //    {
        //        ListViewDataItem item = (ListViewDataItem)e.Item;

        //        ListView innerList = (ListView)item.FindControl("ListView2");

        //        innerList.DataBind();
        //    }
        //}
        //catch { }
    }
    protected void ListViewPostComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey = new Guid(((Label)lvi.FindControl("PostIdLabel")).Text);

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId,@CommentUserName)";

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
                myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);
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
            e.Command.Parameters["@UserId"].Value = user_id;
        }
    }

    protected void UserPostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;

    }

    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
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
        MediaDS.SelectCommand = "SELECT * FROM [PhotoComments] WHERE ([PhotoID] = '" + postKey + "') ORDER BY [CommentDate]";
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
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PostId", postKey);



            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);
            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);
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
    protected void ListView2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        if ((e.Item != null) && (e.Item.ItemType == ListViewItemType.InsertItem))
        {
            ImageButton imgin = e.Item.FindControl("ImageProfile5") as ImageButton;
            imgin.ImageUrl = "ThumbnailHandlerPost.ashx?userid=" + currentUserId;

        }



    }
    protected void MediaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = user_id;

        }
        else FormsAuthentication.RedirectToLoginPage();
    }

    protected void btnChangeProfile_Click(object sender, EventArgs e)
    {
        byte[] data = null;
        string imgurl = string.Empty;
        string files_types = string.Empty;
        string files = string.Empty;
        object post__id = null;
        if (FileUploadProfile.HasFile)
        {
            HttpPostedFile file = FileUploadProfile.PostedFile;

            data = new byte[file.ContentLength];

            files_types = file.ContentType;

            file.InputStream.Read(data, 0, file.ContentLength);


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
        string insertSql = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,Description,ContentType,UserFullName,PostType) VALUES(@PostUserId,@ID,@UserId,@UserName,@Description,@ContentType,@UserFullName,@PostType)";

        using (SqlConnection myConnection = new SqlConnection(connectionString2))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand.Parameters.AddWithValue("@PostUserId", currentUserId);
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
        string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string updateSql = "UPDATE UserProfiles SET ProfilePicture = @ProfilePicture,PhotoID=@PhotoID WHERE UserId = @UserId";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);
            myCommand.Parameters.AddWithValue("@ProfilePicture", data);
            myCommand.Parameters.AddWithValue("@PhotoID", post__id);


            myCommand.ExecuteNonQuery();
            myConnection.Close();
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
                string insertSql = "INSERT INTO PhotoStore(PostUserId,ID,UserId,UserName,Description,ContentType,UserFullName,PostType) VALUES(@PostUserId,@ID,@UserId,@UserName,@Description,@ContentType,@UserFullName,@PostType)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@PostUserId", currentUserId);
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
        string insertSql = "INSERT INTO UserComments(Comment, PostId, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PostId, @CommentUser, @CommentUserId,@CommentUserName)";

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
                myCommand.Parameters.AddWithValue("@CommentUserName", User.Identity.Name);

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
                    string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and PostUserId=@PostUserId) order by [Date] desc";
                    SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection3);
                    myCommand4.Parameters.AddWithValue("@UserId", user_id);
                    myCommand4.Parameters.AddWithValue("@PostUserId", currentUserId);

                    post__id = myCommand4.ExecuteScalar();
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
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "<script type='text/javascript'>ClearPostBox();</script>", false);

        ListView1.DataBind();


        

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
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        Guid currentUserId = (Guid)currentUser.ProviderUserKey;



        if (String.Equals(e.CommandName, "LikeButton"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            likeId_in = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[1];
            String like_Id = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            String post_userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            String user_Id = currentUserId.ToString();

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


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo) VALUES(@UserId,@LikeId,@Type,@NotifyTo)";

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
    protected void ListViewPostComment_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postIdc = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userIdc = lv.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

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
                    if (userIdc == uid && likeIdc == lid)
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
                myCommand.Parameters.AddWithValue("@LikeId", likeIdc);


                Int32 count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }



        }
        catch { }
    }
    protected void ListViewPostComment_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            //likeId_inc = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[1];

            Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            likeId_inc = new Guid(likeidlbl.Text);
            if (String.Equals(lbtn.Text, "Like"))
            {

                string connectionString =
                       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", likeId_inc);
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

            if (String.Equals(lbtn.Text, "Unlike"))
            {
                string connectionString =
                       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string deleteSql = "delete from UserLikes where LikeId=@LikeId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(deleteSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", likeId_inc);


                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }

            }

        }
        this.DataBind();
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

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            String user_Id = currentUserId.ToString();
            string post_userId = e.CommandArgument.ToString();
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


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo) VALUES(@UserId,@LikeId,@Type,@NotifyTo)";

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
    protected void CommentsDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;
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
            //ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //Guid code = (Guid)ListView1.DataKeys[dataItem.DisplayIndex].Value;
            //likeId_inc = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[1];

            Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            likeId2_inc = new Guid(likeidlbl.Text);
            if (String.Equals(lbtn.Text, "Like"))
            {

                string connectionString =
                       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string insertSql = "INSERT INTO UserLikes(LikeId,LikeUser,UserId) VALUES(@LikeId,@LikeUser,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", likeId2_inc);
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

            if (String.Equals(lbtn.Text, "Unlike"))
            {
                string connectionString =
                       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


                string deleteSql = "delete from UserLikes where LikeId=@LikeId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(deleteSql, myConnection);
                    myCommand.Parameters.AddWithValue("@LikeId", likeId2_inc);


                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }

            }

        }
        this.DataBind();
    }
    protected void PostsDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        string req = SendFriendReq.Text;
        
        if (user_id.ToString()== currentUserId.ToString())
            {

                e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ([UserId] = @UserId and [PostType]='profile') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ([UserId] = @UserId and [PostType]='profile'))  order by [Date] desc";
                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
                e.Command.Parameters.Add(new SqlParameter("@UserId", user_id));


            }
        if (req == "Friends")
        {
            e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ([UserId] = @UserId and [PostType]='profile' and Privacy <> 'Only Me') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ([UserId] = @UserId and [PostType]='profile' and Privacy <> 'Only Me'))  order by [Date] desc";
            e.Command.Parameters.Clear();
            e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
            e.Command.Parameters.Add(new SqlParameter("@UserId", user_id));
        }
        if (req == "Add Friend" || req == "Request Pending")
        {
            e.Command.CommandText = "(SELECT top(@TopVal) * FROM PhotoStore WHERE ([UserId] = @UserId and [PostType]='profile' and Privacy = 'Public') UNION ALL SELECT top(@TopVal) * FROM VideoStore WHERE ([UserId] = @UserId and [PostType]='profile' and Privacy <> 'Public'))  order by [Date] desc";
            e.Command.Parameters.Clear();
            e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
            e.Command.Parameters.Add(new SqlParameter("@UserId", user_id));
        }

    }
    protected void ImageButtonGrid_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/index_m.aspx?un=" + user_name);
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/profile-list_m.aspx?un=" + user_name);
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


                    string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo) VALUES(@UserId,@Type,@NotifyTo)";

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
    protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        byte[] image = null;
        string imgurl = string.Empty;
        string files_types = string.Empty;
        string files = string.Empty;
        object post__id = null;
        try
        {
            image = e.GetContents();


            using (System.Drawing.Image source = byteArrayToImage(image))
            {
                ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                EncoderParameters parameters = new EncoderParameters(3);
                parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);

                source.Save(Server.MapPath("~") + "/uploads/" + e.FileName, codec, parameters);
                image = File.ReadAllBytes(Server.MapPath("~") + "/uploads/" + e.FileName);
            }


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
                string insertSql = "INSERT INTO PhotoStore(PostUserId,ID, PostType,UserId,UserName,Description,ContentType,UserFullName) VALUES(@PostUserId,@ID, @PostType,@UserId,@UserName,@Description,@ContentType,@UserFullName)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@PostUserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@UserName", User.Identity.Name);
                    myCommand.Parameters.AddWithValue("@UserFullName", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Description", HttpContext.Current.Session["user"] + " has updated background photo");
                    myCommand.Parameters.AddWithValue("@ContentType", "image");
                    myCommand.Parameters.AddWithValue("@PostType", "profile");



                    myCommand.ExecuteNonQuery();
                    string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                    SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection);
                    myCommand4.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                    post__id = myCommand4.ExecuteScalar();
                    myConnection.Close();
                }

                //File.Move(Server.MapPath("~") + "/uploads/" + e.FileName, Server.MapPath("~") + imgurl);
                using (System.Drawing.Image source2 = byteArrayToImage(image))
                {
                    ImageCodecInfo codec = ImageCodecInfo.GetImageEncoders().First(c => c.MimeType == "image/jpeg");
                    EncoderParameters parameters = new EncoderParameters(3);
                    parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                    parameters.Param[1] = new EncoderParameter(System.Drawing.Imaging.Encoder.ScanMethod, (int)EncoderValue.ScanMethodInterlaced);
                    parameters.Param[2] = new EncoderParameter(System.Drawing.Imaging.Encoder.RenderMethod, (int)EncoderValue.RenderProgressive);
                    MembershipUser mu = Membership.GetUser(currentUserId);
                    string user_name = mu.UserName;
                    imgurl = "/uploads/" + user_name + "/photos/backgrounds/" + post__id + e.ContentType;
                    source2.Save(Server.MapPath("~") + imgurl, codec, parameters);

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
                e.DeleteTemporaryData();
            }
            this.DataBind();
        }
        catch { }

    }
    protected void circlemoreDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = user_id;
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
    protected void ListView2_ItemEditing(object sender, ListViewEditEventArgs e)
    {
        ListView lvs = sender as ListView;
        //ListView1.DataBind();
        //lvs.DataBind();
        lvs.EditIndex = e.NewEditIndex;
        lvs.DataBind();
        //lvs.InsertItemPosition = InsertItemPosition.None;

        //lvs.SetEditItem(e);
        //ListViewDataItem ctl = (ListViewDataItem)ListView1.FindControl(lvs.Parent.ID);

        //if (ctl != null)
        //{
        //    ListView lv = (ListView)ctl.FindControl("ListView2");

        //    lv.EditIndex = e.NewEditIndex;



        //}
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
        topselval += 4;
        ListView1.DataBind();
        //this.PostsDataSource1.SelectParameters["TopVal"].DefaultValue = (int.Parse(this.PostsDataSource1.SelectParameters["TopVal"].DefaultValue) + 4).ToString();
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
    protected void lvProfileComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        ListView lv = (ListView)sender;
        //Panel lvi = (Panel)lv.Parent;
        //postKey = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);

        string post_userId = profile_userid.ToString();

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PhotoID", profile_photoid);


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
        this.DataBind();
        UpdatePanel1.Update();
    }
    protected void ListViewPostComment2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {
            ListView lv = (ListView)sender;
            postIdc = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
            likeIdc = lv.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userIdc = lv.DataKeys[e.Item.DataItemIndex].Values[3].ToString();

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
    protected void UserProfile_ItemCreated(object sender, EventArgs e)
    {
        DetailsView lv = (DetailsView)sender;
        try
        {

            comment_select_profile = (Guid)lv.DataKey[1];
            profile_userid = (Guid)lv.DataKey[0];
            profile_photoid = (Guid)lv.DataKey[1];
        }
        catch { }
        try
        {
            if (currentUserId.ToString() == user_id.ToString())
            {
                ImageButton imgbtn = (UserProfile.FindControl("imgchange")) as ImageButton; imgbtn.Visible = true;
            }
            else
            {
                ImageButton imgbtn = (UserProfile.FindControl("imgchange")) as ImageButton; imgbtn.Visible = false;
            }
        }
        catch { }
    }

    protected void lvCoverComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        ListView lv = (ListView)sender;
        //Panel lvi = (Panel)lv.Parent;
        //postKey = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);

        string post_userId = cover_userid.ToString();

        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PhotoID", cover_photoid);


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
        this.DataBind();
        UpdatePanel2.Update();
    }
    protected void MediaDS_Cover_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = comment_select_cover;
    }
    protected void UserCover_ItemCreated(object sender, EventArgs e)
    {
         DetailsView lv = (DetailsView)sender;
        //System.Web.UI.HtmlControls.HtmlAnchor hlp = lv.FindControl("profile_pop") as System.Web.UI.HtmlControls.HtmlAnchor;
        //Control popdiv = lv.FindControl("inline_content_pop") as Control;
        //hlp.HRef = "#" + popdiv.ClientID;

        try
        {

            comment_select_cover = (Guid)lv.DataKey[1];
            cover_userid = (Guid)lv.DataKey[0];
            cover_photoid = (Guid)lv.DataKey[1];
        }
        catch { }
        try
        {

            if (currentUserId.ToString() == user_id.ToString())
            {
                ImageButton imgbtn = (UserCover.FindControl("btnChangeCoverPic")) as ImageButton; imgbtn.Visible = true;
            }
            else
            {
                ImageButton imgbtn = (UserCover.FindControl("btnChangeCoverPic")) as ImageButton; imgbtn.Visible = false;
            }
        }
        catch { }
    }
    protected void MediaDS_Profile_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = comment_select_profile;
    }
}