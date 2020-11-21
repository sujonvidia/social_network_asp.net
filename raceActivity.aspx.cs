using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    Guid raceId, raceIdc, raceId2c, postId_edit;
    Guid raceId2;
    Guid raceKey;
    Guid raceKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static String category = "All";
    static Guid sharepostId, shareuserId;
    Guid currentUserId;
    static int topselval = 0;
    string user_name;
    Guid user_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Page.Title =  HttpContext.Current.Session["user"].ToString();
            MembershipUser currentUser = Membership.GetUser();

            currentUserId = (Guid)currentUser.ProviderUserKey;
            (this.Master as MasterPage2).UpdateNotifications(currentUserId);

        }
        else
        {
            Response.Redirect("~/login.aspx");
        }
        if (Request.Cookies["user_name"] != null)
        {
            if (!String.IsNullOrEmpty(Request.Cookies["user_name"].Value))
            {
                user_name = Request.Cookies["user_name"].Value;
            }
        }
        ImageProfile.ImageUrl = "ThumbnailHandlerProfile.ashx?userid=" + currentUserId;
    }

    public int highest_limit_group(int a, int n)
    {
        int P = a * (int)(Math.Pow(2, n) + (Math.Pow(2, n) - 1));
        return P;
    }
    public int lowest_limit_group(int a, int P)
    {
        int Q = (P-a)/2;
        return Q;
    }
    public int range_of_group(int P, int Q)
    {
        int R = (P-Q);
        return R;
    }
    public int highest_limit_rank(int R, int r,int m)
    {
        int S = (R/r)*m;
        return S;
    }
    public int lowest_limit_rank(int R, int r, int m)
    {
        int T = (R / r) * (m-1);
        return T;
    }
    public int range_of_rank(int S, int T)
    {
        int U = S-T;
        return U;
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
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            //if (txtNewPost.Text != string.Empty)
            //{
            string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO RacePosts(RacePost, UserId, RaceContent, RaceContentType, RacePostUser,Category,SubCategory) VALUES(@RacePost, @UserId, @RaceContent, @RaceContentType, @RacePostUser,@Category,@SubCategory)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@RacePost", txtNewPost.Text.Trim());
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@RacePostUser", HttpContext.Current.Session["user"]);
                myCommand.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                myCommand.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
                if (FileUpload1.HasFile)
                {
                    HttpPostedFile file = FileUpload1.PostedFile;

                    byte[] data = new byte[file.ContentLength];

                    file.InputStream.Read(data, 0, file.ContentLength);
                    myCommand.Parameters.AddWithValue("@RaceContent", data);
                    myCommand.Parameters.AddWithValue("@RaceContentType", file.ContentType);
                }
                else
                {
                    myCommand.Parameters.AddWithValue("@RaceContent", new byte[0]);
                    myCommand.Parameters.AddWithValue("@RaceContentType", DBNull.Value);

                }

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            txtNewPost.Text = string.Empty;
            Guid race_id_;
            string connectionString3 =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql3 = "select [RaceId] from [RacePosts] WHERE UserId=@UserId order by [RacePostDate] desc";

            using (SqlConnection myConnection = new SqlConnection(connectionString3))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);



                 race_id_ = (Guid)myCommand.ExecuteScalar();
                myConnection.Close();
            }
            
           
            string connectionString2 =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql2 = "INSERT INTO RacePoints(RaceId, MyId, Activity, SubCategory,Iweu) VALUES(@RaceId, @MyId, @Activity, @SubCategory,@Iweu)";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                myCommand.Parameters.AddWithValue("@RaceId", race_id_);
                myCommand.Parameters.AddWithValue("@MyId", currentUserId);
                myCommand.Parameters.AddWithValue("@Activity", "Publish");
                myCommand.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
                myCommand.Parameters.AddWithValue("@Iweu", 3);


                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            // }
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
                e.Command.CommandText = "SELECT top(@TopVal) RacePosts.RaceId, RacePosts.RacePost, RacePosts.RacePostDate, RacePosts.UserId, RacePosts.RaceContent, RacePosts.RaceContentType, RacePosts.RacePostUser, RacePosts.LikeId, RacePosts.DislikeId, RacePosts.Category, RacePosts.SubCategory, RacePoints.Activity, RacePoints.SubCategory, RacePoints.Iweu, RacePoints.MyId FROM RacePosts INNER JOIN RacePoints ON RacePosts.RaceId = RacePoints.RaceId where (RacePoints.MyId=@MyId and RacePoints.Activity=@Activity) ORDER BY [Iweu] DESC";
                e.Command.Parameters.Clear();
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
                e.Command.Parameters.Add(new SqlParameter("@MyId", currentUserId));
                e.Command.Parameters.Add(new SqlParameter("@Activity", "Publish"));


                //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
                //e.Command.Parameters["@Category"].Value = category;


            }
            else if (category.Contains("/"))
            {
                string[] cat = category.Split('/');
                e.Command.CommandText = "SELECT top(@TopVal) RacePosts.RaceId, RacePosts.RacePost, RacePosts.RacePostDate, RacePosts.UserId, RacePosts.RaceContent, RacePosts.RaceContentType, RacePosts.RacePostUser, RacePosts.LikeId, RacePosts.DislikeId, RacePosts.Category, RacePosts.SubCategory, RacePoints.Activity, RacePoints.SubCategory, RacePoints.Iweu, RacePoints.MyId FROM RacePosts INNER JOIN RacePoints ON RacePosts.RaceId = RacePoints.RaceId WHERE (RacePosts.Category=@Category AND RacePosts.SubCategory=@SubCategory and RacePoints.MyId=@MyId and RacePoints.Activity=@Activity) ORDER BY [Iweu] DESC";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", cat[0]));
                e.Command.Parameters.Add(new SqlParameter("@SubCategory", cat[1]));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
                e.Command.Parameters.Add(new SqlParameter("@MyId", currentUserId));
                e.Command.Parameters.Add(new SqlParameter("@Activity", "Publish"));
            }
            else
            {
                e.Command.CommandText = "SELECT top(@TopVal) RacePosts.RaceId, RacePosts.RacePost, RacePosts.RacePostDate, RacePosts.UserId, RacePosts.RaceContent, RacePosts.RaceContentType, RacePosts.RacePostUser, RacePosts.LikeId, RacePosts.DislikeId, RacePosts.Category, RacePosts.SubCategory, RacePoints.Activity, RacePoints.SubCategory, RacePoints.Iweu, RacePoints.MyId FROM RacePosts INNER JOIN RacePoints ON RacePosts.RaceId = RacePoints.RaceId WHERE (RacePosts.Category=@Category and RacePoints.MyId=@MyId and RacePoints.Activity=@Activity) ORDER BY [RacePoints.Iweu] DESC";
                e.Command.Parameters.Clear();

                e.Command.Parameters.Add(new SqlParameter("@Category", category));
                e.Command.Parameters.Add(new SqlParameter("@TopVal", topselval));
                e.Command.Parameters.Add(new SqlParameter("@MyId", currentUserId));
                e.Command.Parameters.Add(new SqlParameter("@Activity", "Publish"));
            }
        }

    }

    //protected void RaceMediaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    //{
    //    MembershipUser currentUser = Membership.GetUser();

    //    if (currentUser != null)
    //    {
    //        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
    //        if (category == "All")
    //        {

    //            e.Command.CommandText = "SELECT * FROM [RacePosts] WHERE (([RaceContentType] IS NOT NULL)) ORDER BY [RacePostDate] DESC";
    //            e.Command.Parameters.Clear();

    //            //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
    //            //e.Command.Parameters["@Category"].Value = category;


    //        }
    //        else if (category.Contains("/"))
    //        {
    //            string[] cat = category.Split('/');
    //            e.Command.CommandText = "SELECT * FROM [RacePosts] WHERE (([RaceContentType] IS NOT NULL) AND [Category]=@Category AND [SubCategory]=@SubCategory) ORDER BY [RacePostDate] DESC";
    //            e.Command.Parameters.Clear();

    //            e.Command.Parameters.Add(new SqlParameter("@Category", cat[0]));
    //            e.Command.Parameters.Add(new SqlParameter("@SubCategory", cat[1]));
    //        }
    //        else
    //        {
    //            e.Command.CommandText = "SELECT * FROM [RacePosts] WHERE ([RaceContentType] IS NOT NULL) AND [Category]=@Category) ORDER BY [RacePostDate] DESC";
    //            e.Command.Parameters.Clear();

    //            e.Command.Parameters.Add(new SqlParameter("@Category", category));
    //        }
    //    }

    //}

    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        try
        {


            raceId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            userId = ListView1.DataKeys[e.Item.DataItemIndex].Values[2].ToString();

            Button lb = e.Item.FindControl("LinkButtonLike") as Button;
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


                while (rdr.Read())
                {
                    String uid = rdr["UserId"].ToString();
                    String lid = rdr["LikeId"].ToString();
                    if (userId == uid && likeId == lid)
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
        string insertSql = "INSERT INTO RaceComments(RaceComment, RaceId, RaceCommentUser,CommentUserId) VALUES(@RaceComment, @RaceId, @RaceCommentUser,@CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@RaceComment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@RaceId", raceKey);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);



            myCommand.Parameters.AddWithValue("@RaceCommentUser", HttpContext.Current.Session["user"]);

            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }
        if (currentUserId.ToString() != post_userId)
        {
            string connectionString12 =
                  ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;


            string insertSql2 = "INSERT INTO Notifications(UserId,Type,NotifyTo) VALUES(@UserId,@Type,@NotifyTo)";

            using (SqlConnection myConnection = new SqlConnection(connectionString12))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);

                myCommand.Parameters.AddWithValue("@Type", "Race_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        e.Cancel = true;
        this.DataBind();

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

        TextBox txtb = (e.Item.FindControl("RaceCommentTextBox")) as TextBox;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO RaceComments(RaceComment, RaceId, RaceCommentUser,CommentUserId) VALUES(@RaceComment, @RaceId, @RaceCommentUser,@CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@RaceComment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@RaceId", raceKey2);
            MembershipUser currentUser = Membership.GetUser();

            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;


                myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);

            }

            myCommand.Parameters.AddWithValue("@RaceCommentUser", HttpContext.Current.Session["user"]);

            myCommand.ExecuteNonQuery();
            myConnection.Close();

        }

        e.Cancel = true;
        this.DataBind();
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {


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


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo) VALUES(@UserId,@LikeId,@Type,@NotifyTo)";

                    using (SqlConnection myConnection = new SqlConnection(connectionString12))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                        myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                        myCommand.Parameters.AddWithValue("@Type", "Race_Post_Like");
                        myCommand.Parameters.AddWithValue("@UserId", user_Id);
                        myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
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


                    string insertSql2 = "INSERT INTO Notifications(UserId,LikeId,Type,NotifyTo) VALUES(@UserId,@LikeId,@Type,@NotifyTo)";

                    using (SqlConnection myConnection = new SqlConnection(connectionString12))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
                        myCommand.Parameters.AddWithValue("@LikeId", like_Id);
                        myCommand.Parameters.AddWithValue("@Type", "Race_Comment_Like");
                        myCommand.Parameters.AddWithValue("@UserId", user_Id);
                        myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
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
            raceId2c = (Guid)lv.DataKeys[e.Item.DataItemIndex].Values[0];
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
    protected void ImageButtonGrid_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/race_m.aspx");
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/race-list_m.aspx");
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
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;

        byte[] data = null;
        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select RaceContent, RaceContentType from RacePosts where RaceId='" + raceId + "'", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {
                //context.Response.ContentType = rdr["PostContentType"].ToString();
                data = ((byte[])rdr["RaceContent"]);

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
        try
        {
            if (data != null && data.Length > 0)
            {

                e.Item.FindControl("embed1").Visible = true;
                Panel myDiv = (Panel)e.Item.FindControl("post_backcolor");
                myDiv.Attributes.Add("style", "background-color:white;");
            }
        }
        catch { }
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

    protected void LoadMore_Click(object sender, EventArgs e)
    {
        //string s=  this.RacePostDataSource.SelectParameters.Count.ToString();
        //  //this.RacePostDataSource.SelectParameters["TopVal"].DefaultValue = (int.Parse(this.RacePostDataSource.SelectParameters["TopVal"].DefaultValue) + 4).ToString();

        //   RacePostDataSource.SelectCommand = "SELECT top(@TopVal) * FROM [RacePosts] ORDER BY [RacePostDate] DESC";
        //  RacePostDataSource.SelectParameters.Clear();
        //  RacePostDataSource.SelectParameters.Add("TopVal", "8");

        ListView1.DataBind();

    }
    protected void btnMyIweu_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/myiweu.aspx");

    }
    protected void btnPointCurrent_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PO_Current.aspx");
    }
    protected void btnPointAll_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/PO_All.aspx");
    }
}