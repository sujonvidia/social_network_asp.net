using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default4 : System.Web.UI.Page
{
  static  Guid postid;

    Guid postId, postIdc, postId2c, postId_edit, postIdmedia;
    Guid currentUserId;
    Guid postKey;
    static Guid postId2;
    Guid postKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static Guid sharepostId, shareuserId;
    object AlbumID;
    static byte[] data, data2;
    static HttpPostedFile filep;
    string user_name;
    Guid user_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Page.Title = HttpContext.Current.Session["user"].ToString();
            MembershipUser currentUser = Membership.GetUser();

            currentUserId = (Guid)currentUser.ProviderUserKey;
          

        }
        else
        {
            Response.Redirect("~/login.aspx");
        }
        try
        {
            postid = new Guid(Request.QueryString["postid"]);
        }
        catch { }
        string connectionString3 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string selectSql = "update [Notifications] set [MarkasRead] = 1  where (PostId=@PostId and NotifyTo=@NotifyTo)";

        using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
        {
            myConnection2.Open();
            SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
            myCommand2.Parameters.AddWithValue("@PostId", postid);
            myCommand2.Parameters.AddWithValue("@NotifyTo", currentUserId);

             myCommand2.ExecuteNonQuery();
            myConnection2.Close();
        }
        (this.Master as MasterPage2).UpdateNotifications(currentUserId);
    }
    protected void MediaDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = postId;
    }
    protected void lvMediaComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListView lv = (ListView)sender;
        Panel lvi = (Panel)lv.Parent;
        postKey = new Guid(((Label)lvi.FindControl("PhotoIDLabel")).Text);

        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        string like_Id = ((Label)lvi.FindControl("LikeIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO PhotoComments(Comment, PhotoID, CommentUser, CommentUserId,CommentUserName) VALUES(@Comment, @PhotoID, @CommentUser, @CommentUserId,@CommentUserName)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@PhotoID", postid);


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


                string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo,PostId,LikeId) VALUES(@UserId,@Type,@NotifyTo,@PostId,@LikeId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString12))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);

                    myCommand.Parameters.AddWithValue("@Type", "Post_Comment");
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
                    myCommand.Parameters.AddWithValue("@PostId", postid);
                    myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();

                }

            }
        }
        catch { }

        e.Cancel = true;
        this.DataBind();
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PhotoID"].Value = postid;
    }
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Guid post_id = Guid.Empty; String like_Id = ""; String post_userId = "";
        Guid currentUserId = Guid.Empty; String user_Id = "";

        try
        {

            like_Id = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            post_userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();
            MembershipUser currentUser = Membership.GetUser();
            post_id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];

            currentUserId = (Guid)currentUser.ProviderUserKey;
            user_Id = currentUserId.ToString();
        }
        catch { }
        if (String.Equals(e.CommandName, "allcomment"))
        {
            //Panel cp=  ListView1.FindControl("PanelPostComment") as Panel;
            //string cpanel = cp.ClientID;
            postId = post_id;
            //PostCommentDataSource.SelectCommand = "SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]";
            //PostCommentDataSource.SelectParameters.Clear();
            //PostCommentDataSource.SelectParameters.Add("PostId", post_id.ToString());
            PostCommentDataSource.DataBind();
            //return;

        }

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
                        Guid post__id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
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
            //MPEShare.Show();

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
            Guid post_Id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string Sql = "delete from [UserPosts] WHERE [PostId]=@PostId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                myCommand.Parameters.AddWithValue("@PostId", post_Id);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            //ListView2.DataBind();
            //UpdatePanel1.Update();

        }
        ListView1.DataBind();
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
    protected void UserPostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@PostId"].Value = postId;

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
            Label postidlbl = e.Item.FindControl("PostIdLabel") as Label;
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
                        //ListView lstview = sender as ListView;
                        //Guid post__id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
                        myCommand.Parameters.AddWithValue("@PostId", postidlbl.Text);

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
        catch {  }
    }

    protected void ListViewPostComment_ItemInserting(object sender, ListViewInsertEventArgs e)
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
}