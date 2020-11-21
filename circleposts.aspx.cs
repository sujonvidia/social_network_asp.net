using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    Guid postId, postIdc, postId2c, postId_edit;
    Guid currentUserId;
    Guid postKey;
    Guid postId2;
    Guid postKey2;
    String likeId, likeIdc, likeId2, likeId2c;
    String userId, userIdc, userId2, userId2c;
    Guid likeId_in, likeId_inc, likeId2_in, likeId2_inc;
    static Guid sharepostId, shareuserId;
    object AlbumID;
    byte[] data, data2;
    static String cname;
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
        cname = Request.QueryString["cname"];
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
            e.Command.Parameters["@UserId"].Value = currentUserId;
        }
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
            e.Command.Parameters["@my_id"].Value = currentUserId;
            e.Command.Parameters["@me"].Value = currentUserId;
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
            e.Command.Parameters["@my_id"].Value = currentUserId;
            e.Command.Parameters["@me"].Value = currentUserId;
        }
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


    protected void btnPhoto_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/photos.aspx");
    }
    protected void ListView1_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        //Label lbl = (ListView1.Items[e.ItemIndex].FindControl("PostIdLabel")) as Label;
        //if (lbl != null) postId_edit = new Guid(lbl.Text);
        //TextBox txt = (ListView1.Items[e.ItemIndex].FindControl("PostTextBox")) as TextBox;
        // String edit_text = txt.Text; 

    }
    protected void PostDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {

    }

    protected void ListView1_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        // }

    }
    protected void CancelButton_Click(object sender, EventArgs e)
    {

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
    protected void CircleFriendsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

        e.Command.Parameters["@my_id"].Value = currentUserId;
    }
    protected void btnCircleFamilyAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtCircleFamilyAdd.Text))
            {
                string connectionString4 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql3 = "INSERT INTO CircleMembers(MemberId, CircleName, UserId) VALUES(@MemberId, @CircleName, @UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString4))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@MemberId", new Guid(txtCircleFamilyID.Text));
                    myCommand.Parameters.AddWithValue("@CircleName", "Family");

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                this.DataBind();
            }
        }
        catch { }
    }
    protected void CircleFamilyDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void btnCircleAcquaintancesAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtCircleAcquaintancesAdd.Text))
            {
                string connectionString4 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql3 = "INSERT INTO CircleMembers(MemberId, CircleName, UserId) VALUES(@MemberId, @CircleName, @UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString4))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    myCommand.Parameters.AddWithValue("@MemberId", new Guid(txtCircleAcquaintancesId.Text));
                    myCommand.Parameters.AddWithValue("@CircleName", "Acquaintances");

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                this.DataBind();
            }
        }
        catch { }
    }
    protected void AcquaintancesDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void CirclePostDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
        e.Command.Parameters["@CircleName"].Value = cname;
    }
    protected void lstCircleMore_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "morecircle"))
        {
            Button btncircle = e.Item.FindControl("ButtonLabel") as Button;
            Response.Redirect("~/circleposts.aspx?cname=" + btncircle.Text);

        }
    }
    protected void btnFriend_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/friends.aspx");
    }
}