using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Default4 : System.Web.UI.Page
{
    Guid postid;

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
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@RaceId"].Value = postid;
    }
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
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
    }
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        //HtmlButton htb = e.Item.FindControl("racepost") as HtmlButton;
        //AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        //trigger.ControlID = htb.UniqueID;
        //UpdatePanel1.Triggers.Add(trigger);
        //ScriptManager sm = this.Master.FindControl("MasterScriptManager") as ScriptManager;
        //sm.RegisterAsyncPostBackControl(htb);

        // var span1 = e.Item.FindControl("racepost") as HtmlGenericControl;

        //Guid _raceId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
        //span1.ID = _raceId.ToString();
        //span1.Attributes["onclick"] = ClientScript.GetPostBackEventReference(this, "ClickRacePost");
    }
    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {


            raceId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
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
        catch { }

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
            Guid post_Id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string Sql = "delete from [RacePosts] WHERE [RaceId]=@RaceId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                myCommand.Parameters.AddWithValue("@RaceId", post_Id);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            //ListView2.DataBind();
            //UpdatePanel1.Update();

        }
        this.DataBind();
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

                e.Command.CommandText = "SELECT top(@TopVal) * FROM [RacePosts] WHERE (([RaceContentType] IS NULL)) ORDER BY [RacePostDate] DESC";
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
 
    protected void RacePostCommentDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@RaceId"].Value = raceId;
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
}