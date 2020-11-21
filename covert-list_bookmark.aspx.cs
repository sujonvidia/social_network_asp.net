using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Default5 : System.Web.UI.Page
{
    public Guid covertId;
    public Guid covertKey;
    Label covertlbl;
    Guid currentUserId, postId_edit;
    static String category = "All";
    String likeId, likeIdc, likeId2, likeId2c;
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
            string insertSql = "INSERT INTO CovertPosts(CovertPost, CovertPostUser, UserId, CovertContent, CovertContentType,CovertAvatar,Category,PostTitle) VALUES(@CovertPost, @CovertPostUser, @UserId, @CovertContent, @CovertContentType,@CovertAvatar,@Category,@PostTitle)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@CovertPost", txtNewPost.Text.Trim());
                myCommand.Parameters.AddWithValue("@CovertPostUser", txtPostedby.Text);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@PostTitle", txtPostTitle.Text);

                myCommand.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                if (txtPostedby.Text == "anonymous")
                {
                    byte[] bytes = File.ReadAllBytes(System.AppDomain.CurrentDomain.BaseDirectory + "images\\logo_covert.png");
                    myCommand.Parameters.AddWithValue("@CovertAvatar", bytes);
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
                            myCommand.Parameters.AddWithValue("@CovertAvatar", bytes);

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
                    myCommand.Parameters.AddWithValue("@CovertAvatar", bytes);
                }

                //
                //{

                if (FileUpload1.HasFile)
                {
                    HttpPostedFile file = FileUpload1.PostedFile;

                    byte[] data = new byte[file.ContentLength];

                    file.InputStream.Read(data, 0, file.ContentLength);
                    myCommand.Parameters.AddWithValue("@CovertContent", data);
                    myCommand.Parameters.AddWithValue("@CovertContentType", file.ContentType);
                }
                else
                {
                    myCommand.Parameters.AddWithValue("@CovertContent", new byte[0]);
                    myCommand.Parameters.AddWithValue("@CovertContentType", DBNull.Value);

                }
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            txtNewPost.Text = string.Empty;
            // }
        }
        //    Session["result"] = "Complete";
        //}
        this.DataBind();
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
            txtPostedby.Text = currentUser.UserName;
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        txtPostedby.Text = "anonymous";
    }

    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        Int32 count;
        try
        {
            covertId = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Value;
            likeId = ListView1.DataKeys[e.Item.DataItemIndex].Values[1].ToString();
            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select COUNT(*) from [UserLikes] WHERE LikeId=@LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeId", likeId);


                count = (Int32)myCommand.ExecuteScalar();


                HyperLink lbcount = e.Item.FindControl("LikeCountLabel") as HyperLink;
                lbcount.Text = count.ToString() + " people like this.";

                myConnection.Close();

            }

            string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "UPDATE CovertPosts SET [LikeCount] = @LikeCount WHERE LikeId = @LikeId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@LikeCount", count);
                myCommand.Parameters.AddWithValue("@LikeId", likeId);


                myCommand.ExecuteNonQuery();
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
        HtmlTableCell lvi = (HtmlTableCell)lv.Parent;
        covertKey = new Guid(((Label)lvi.FindControl("CovertIdLabel")).Text);
        string post_userId = ((Label)lvi.FindControl("UserIdLabel")).Text;
        TextBox txtb = (e.Item.FindControl("CommentTextBox")) as TextBox;
        //txt = txtb.Text;


        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql = "INSERT INTO CovertComments(Comment, CommentUser, CovertId,CommentUserId) VALUES(@Comment, @CommentUser, @CovertId,@CommentUserId)";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            myCommand.Parameters.AddWithValue("@Comment", txtb.Text.Trim());
            myCommand.Parameters.AddWithValue("@CovertId", covertKey);



            myCommand.Parameters.AddWithValue("@CommentUserId", currentUserId);
            myCommand.Parameters.AddWithValue("@CommentUser", HttpContext.Current.Session["user"]);



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

                myCommand.Parameters.AddWithValue("@Type", "Covert_Comment");
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@NotifyTo", post_userId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();

            }

        }
        e.Cancel = true;

        this.DataBind();
    }
    protected void ListView2_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        Int32 count;
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


                count = (Int32)myCommand.ExecuteScalar();


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
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;

        byte[] data = null;
        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select CovertContent, CovertContentType from CovertPosts where CovertId='" + covertId + "'", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {
                //context.Response.ContentType = rdr["PostContentType"].ToString();
                data = ((byte[])rdr["CovertContent"]);

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
    protected void CovertIdLabel_Init(object sender, EventArgs e)
    {
        //covertlbl = (Label)sender;
        //string s = covertlbl.Text;
        //covertId = new Guid(covertlbl.Text);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtPostedby.Text = TextBox1.Text;
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
        Response.Redirect("~/covert_m.aspx?un=" + user_name);
    }
    protected void ImageButtonList_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/covert-list_m.aspx?un=" + user_name);
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
            Response.Redirect("~/covert-list_top10.aspx?un=" + user_name);



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


        }
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
        //MembershipUser currentUser = Membership.GetUser();

        //if (currentUser != null)
        //{
        //    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        //    if (category == "All")
        //    {

        //        e.Command.CommandText = "SELECT * FROM [CovertPosts] WHERE (([UserId] = @UserId)) ORDER BY [CovertPostDate] DESC";
        //        e.Command.Parameters.Clear();
        //        e.Command.Parameters.Add(new SqlParameter("@UserId", currentUserId));
        //        //RacePostDataSource.SelectParameters.Add("UserId",System.Data.DbType.Guid, currentUserId);
        //        //e.Command.Parameters["@Category"].Value = category;


        //    }

        //    else
        //    {
        //        e.Command.CommandText = "SELECT * FROM [CovertPosts] WHERE (([UserId] = @UserId) AND [Category]=@Category) ORDER BY [CovertPostDate] DESC";
        //        e.Command.Parameters.Clear();
        //        e.Command.Parameters.Add(new SqlParameter("@UserId", currentUserId));
        //        e.Command.Parameters.Add(new SqlParameter("@Category", category));
        //    }
        //}
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
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
                        myCommand.Parameters.AddWithValue("@Type", "Covert Post");
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
            Guid post_Id = (Guid)ListView1.DataKeys[e.Item.DataItemIndex].Values[0];



            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string Sql = "delete from [CovertPosts] WHERE [CovertId]=@CovertId and UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                myCommand.Parameters.AddWithValue("@CovertId", post_Id);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            //ListView2.DataBind();
            //UpdatePanel1.Update();

        }
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
                    String covertid = rdr["CovertId"].ToString();
                    String userid = rdr["UserId"].ToString();
                    if (covertid == post_Id.ToString() && userid == currentUserId.ToString())
                    {
                        string connectionString10 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
                        string Sql = "delete from [CovertBookmark] WHERE CovertId=@CovertId and UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(connectionString10))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                            myCommand.Parameters.AddWithValue("@CovertId", new Guid(covertid));
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
                string Sql2 = "INSERT INTO CovertBookmark(CovertId,UserId) VALUES(@CovertId,@UserId)";

                using (SqlConnection myConnection = new SqlConnection(connectionString2))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql2, myConnection);
                    myCommand.Parameters.AddWithValue("@CovertId", post_Id);
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
        this.DataBind();
    }
    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "LikeButtonComment"))
        {
            //Button lbtn = e.Item.FindControl("LinkButtonLike") as Button;

            Label likeidlbl = e.Item.FindControl("LikeIdLabel") as Label;
            String like_Id = likeidlbl.Text;

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
    public string AddEmotes(string sentString)
    {
        sentString = sentString.Replace(":)", "<img src='/regular.gif' alt='Happy!' />");
        sentString = sentString.Replace(":(", "<img src='/sad.gif' alt='Sad...' />");
        return sentString;
    }
    protected void MenuSub_MenuItemClick(object sender, MenuEventArgs e)
    {
        string item = e.Item.Text;
        Response.Redirect("~/covert-list_time.aspx?item=" + item);
    }
}