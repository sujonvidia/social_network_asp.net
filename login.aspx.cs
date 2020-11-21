using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login_page_Default : System.Web.UI.Page
{
    protected TextBox txtp1, txtp2, txtcp1, txtcp2;
    string fullname;
    protected void Page_Load(object sender, EventArgs e)
    {
       
        string startupPath = System.AppDomain.CurrentDomain.BaseDirectory;
        var strRedirect = Request["ReturnUrl"];

        if (strRedirect != null)
            Response.Redirect("~/login.aspx", true);
     
    }
    protected void myLogin_LoginError(object sender, EventArgs e)
    {
        // Determine why the user could not login...
        myLogin.FailureText = "Your login attempt was not successful. Please try again.";

        // Does there exist a User account for this user?
        MembershipUser usrInfo = Membership.GetUser(myLogin.UserName);
        if (usrInfo != null)
        {
            // Is this user locked out?
            if (usrInfo.IsLockedOut)
            {
                myLogin.FailureText = "Your account has been locked out because of too many invalid login attempts. Please contact the administrator to have your account unlocked.";
            }
            else if (!usrInfo.IsApproved)
            {
                myLogin.FailureText = "Your account has not yet been approved. You cannot login until an administrator has approved your account.";
            }

        }
    }
    protected void myLogin_LoggedIn(object sender, EventArgs e)
    {
        //string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //string insertSql = "INSERT INTO OnlineUsers(UserID, Name) VALUES(@UserID, @Name)";

        //using (SqlConnection myConnection = new SqlConnection(connectionString))
        //{
        //    myConnection.Open();
        //    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

        //    myCommand.Parameters.AddWithValue("@Name", HttpContext.Current.Session["user"]);

        //    MembershipUser currentUser = Membership.GetUser();

        //    if (currentUser != null)
        //    {
        //        Guid currentUserId = (Guid)currentUser.ProviderUserKey;


        //        myCommand.Parameters.AddWithValue("@UserID", currentUserId);

        //    }

        //    myCommand.ExecuteNonQuery();
        //    myConnection.Close();

        //}
        //Session["user_name"] = myLogin.UserName;
        Response.Cookies["user_name"].Value = myLogin.UserName;
        myLogin.DestinationPageUrl = "~/index_m.aspx?un=" + myLogin.UserName;
        
    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        try
        {
            // Get the UserId of the just-added user
            MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
            Guid newUserId = (Guid)newUser.ProviderUserKey;

            // Insert a new record into UserProfiles
            string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = @"INSERT INTO UserProfiles(UserId, FirstName, MiddleName, LastName,FullName, E_mail, UserName,  Gender, ProfilePicture, BackgroundPicture,CoverPicture,Day,Month,Year) 
VALUES(@UserId, @FirstName,@MiddleName,@LastName,@FullName,@E_mail,@UserName, @Gender, (SELECT * FROM OPENROWSET(BULK N'" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\default-profile-photo.jpg', SINGLE_BLOB) AS image), (SELECT * FROM OPENROWSET(BULK N'" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\default-background-photo.jpeg', SINGLE_BLOB) AS image),(SELECT * FROM OPENROWSET(BULK N'" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\basic-cover.jpeg', SINGLE_BLOB) AS image),@Day,@Month,@Year)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", newUserId);
                myCommand.Parameters.AddWithValue("@FirstName", ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("FirstName")).Text);
                myCommand.Parameters.AddWithValue("@MiddleName", ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("MiddleName")).Text);
                myCommand.Parameters.AddWithValue("@LastName", ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("LastName")).Text);
                fullname = ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("FirstName")).Text + " " + ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("MiddleName")).Text + " " + ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("LastName")).Text;
                myCommand.Parameters.AddWithValue("@FullName", fullname);
                myCommand.Parameters.AddWithValue("@E_mail", ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Email")).Text);
                myCommand.Parameters.AddWithValue("@UserName", ((TextBox)CreateUserWizardStep1.ContentTemplateContainer.FindControl("UserName")).Text);
                myCommand.Parameters.AddWithValue("@Gender", ((RadioButtonList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("rblGender")).SelectedValue);

              string txtday=  ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day")).SelectedValue;
              string txtmonth = ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month")).SelectedValue;
              string txtyear = ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Year")).SelectedValue;
              if (txtday == "Day")
              {
                  myCommand.Parameters.AddWithValue("@Day", DBNull.Value);
              }
              else
              {
                  myCommand.Parameters.AddWithValue("@Day", ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Day")).SelectedValue);
              }
              if (txtmonth == "Month")
              {
                  myCommand.Parameters.AddWithValue("@Month", DBNull.Value);
              }
              else
              {
                  myCommand.Parameters.AddWithValue("@Month", ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Month")).SelectedValue);
              }
              if (txtyear == "Year")
              {
                  myCommand.Parameters.AddWithValue("@Year", DBNull.Value);
              }
              else
              {
                  myCommand.Parameters.AddWithValue("@Year", ((DropDownList)CreateUserWizardStep1.ContentTemplateContainer.FindControl("Year")).SelectedValue);
              }
                
               
               
                myCommand.ExecuteNonQuery();
                myConnection.Close();
           
            }
            string connectionString2 =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql2 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection2 = new SqlConnection(connectionString2))
            {
                myConnection2.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql2, myConnection2);
                myCommand2.Parameters.AddWithValue("@Name", "ProfilePictures");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection2.Close();
            }
       
     
            object post__id = null;
            object cover__id = null;
            object AlbumID; object AlbumIDC;
           
            string connectionString3 =ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;

            string selectSql = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

            using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
            {
                myConnection2.Open();
                SqlCommand myCommand2 = new SqlCommand(selectSql, myConnection2);
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.Parameters.AddWithValue("@Name", "ProfilePictures");

                AlbumID = myCommand2.ExecuteScalar();
                myConnection2.Close();
            }

       
            string insertSql22 = "INSERT INTO PhotoStore(ID,UserId,PostUserId,UserName,UserFullName,ContentType,Description,PostType) VALUES(@ID,@UserId,@PostUserId,@UserName,@UserFullName,@ContentType,@Description,@PostType)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString3))
            {
                myConnection3.Open();
                SqlCommand myCommand3 = new SqlCommand(insertSql22, myConnection3);
                myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));
                myCommand3.Parameters.AddWithValue("@UserId", newUserId);
                myCommand3.Parameters.AddWithValue("@PostUserId", newUserId);
                myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                myCommand3.Parameters.AddWithValue("@UserFullName", fullname);
                myCommand3.Parameters.AddWithValue("@Description", "Default Profile Photo");
            
                myCommand3.Parameters.AddWithValue("@ContentType", "image");
                myCommand3.Parameters.AddWithValue("@PostType", "profile");



                myCommand3.ExecuteNonQuery();
                string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection3);
                myCommand4.Parameters.AddWithValue("@UserId", newUserId);
                myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumID.ToString()));

                post__id = myCommand4.ExecuteScalar();
                myConnection3.Close();
            }
            try
            {


                
                string connectionString21 =
          ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE PhotoStore SET ImageUrl = @ImageUrl WHERE PhotoID = @PhotoID";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(updateSql, myConnection3);
                    myCommand3.Parameters.AddWithValue("@PhotoID", post__id);
                    myCommand3.Parameters.AddWithValue("@ImageUrl", "~/images/default-profile-photo.jpg");
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }
                string updateSql2 = "UPDATE UserProfiles SET PhotoID = @PhotoID WHERE UserId = @UserId";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(updateSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@PhotoID", post__id);
                    myCommand3.Parameters.AddWithValue("@UserId", newUserId);
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }
    
          
            }
            catch
            {

            }
            string connectionString33 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql3 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString33))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql3, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "CoverPhotos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string selectSql22 = "SELECT ID FROM PhotoAlbums WHERE UserId=@UserId AND Name=@Name";

            using (SqlConnection myConnection2 = new SqlConnection(connectionString3))
            {
                myConnection2.Open();
                SqlCommand myCommand2 = new SqlCommand(selectSql22, myConnection2);
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.Parameters.AddWithValue("@Name", "CoverPhotos");

                AlbumIDC = myCommand2.ExecuteScalar();
                myConnection2.Close();
            }


            string insertSql222 = "INSERT INTO PhotoStore(ID,UserId,PostUserId,UserName,UserFullName,ContentType,Description,PostType) VALUES(@ID,@UserId,@PostUserId,@UserName,@UserFullName,@ContentType,@Description,@PostType)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString3))
            {
                myConnection3.Open();
                SqlCommand myCommand3 = new SqlCommand(insertSql222, myConnection3);
                myCommand3.Parameters.AddWithValue("@ID", new Guid(AlbumIDC.ToString()));
                myCommand3.Parameters.AddWithValue("@UserId", newUserId);
                myCommand3.Parameters.AddWithValue("@PostUserId", newUserId);
                myCommand3.Parameters.AddWithValue("@UserName", User.Identity.Name);
                myCommand3.Parameters.AddWithValue("@UserFullName", fullname);
                myCommand3.Parameters.AddWithValue("@Description", "Default Cover Photo");

                myCommand3.Parameters.AddWithValue("@ContentType", "image");
                myCommand3.Parameters.AddWithValue("@PostType", "profile");



                myCommand3.ExecuteNonQuery();
                string selectSql2 = "select [PhotoID] from [PhotoStore] where ([UserId]=@UserId and ID=@ID) order by [Date] desc";
                SqlCommand myCommand4 = new SqlCommand(selectSql2, myConnection3);
                myCommand4.Parameters.AddWithValue("@UserId", newUserId);
                myCommand4.Parameters.AddWithValue("@ID", new Guid(AlbumIDC.ToString()));

                cover__id = myCommand4.ExecuteScalar();
                myConnection3.Close();
            }
            try
            {



                string connectionString21 =
          ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE PhotoStore SET ImageUrl = @ImageUrl WHERE PhotoID = @PhotoID";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(updateSql, myConnection3);
                    myCommand3.Parameters.AddWithValue("@PhotoID", cover__id);
                    myCommand3.Parameters.AddWithValue("@ImageUrl", "~/images/basic-cover.jpeg");
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }
                string updateSql2 = "UPDATE UserProfiles SET CoverID = @CoverID WHERE UserId = @UserId";

                using (SqlConnection myConnection3 = new SqlConnection(connectionString21))
                {
                    myConnection3.Open();
                    SqlCommand myCommand3 = new SqlCommand(updateSql2, myConnection3);
                    myCommand3.Parameters.AddWithValue("@CoverID", cover__id);
                    myCommand3.Parameters.AddWithValue("@UserId", newUserId);
                    myCommand3.ExecuteNonQuery();
                    myConnection3.Close();
                }


            }
            catch
            {

            }
            string connectionString4 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql4 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString2))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql4, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "BackgroundPhotos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString5 =
         ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql5 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString5))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql5, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "RacePhotos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString6 =
         ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql6 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString6))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql6, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "CovertPhotos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString7 =
       ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql7 = @"INSERT INTO PhotoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString7))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql7, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "PostPhotos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString8 =
      ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql8 = @"INSERT INTO VideoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString8))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql8, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "PostVideos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString9 =
     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql9 = @"INSERT INTO VideoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString9))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql9, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "RaceVideos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            string connectionString10 =
    ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql10 = @"INSERT INTO VideoAlbums(Name, UserId) 
VALUES(@Name, @UserId)";

            using (SqlConnection myConnection3 = new SqlConnection(connectionString10))
            {
                myConnection3.Open();
                SqlCommand myCommand2 = new SqlCommand(insertSql10, myConnection3);
                myCommand2.Parameters.AddWithValue("@Name", "CovertVideos");
                myCommand2.Parameters.AddWithValue("@UserId", newUserId);
                myCommand2.ExecuteNonQuery();
                myConnection3.Close();
            }
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/profile");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/covers");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/backgrounds");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/posts");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/race");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/photos/covert");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/videos/posts");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/videos/race");
            Directory.CreateDirectory(Server.MapPath("~") + "/uploads/" + CreateUserWizard1.UserName + "/videos/covert");
        }
        catch (Exception ex)
        {
            Membership.DeleteUser(CreateUserWizard1.UserName);
            Context.Items.Add("ErrorMessage", ex.Message);
        }

        //string insertSql2 = "UPDATE UserProfiles SET ProfilePicture = SELECT BulkColumn FROM Openrowset( Bulk '" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\default-profile-photo.jpg', Single_Blob) as image";
        //using (SqlConnection myConnection = new SqlConnection(connectionString))
        //{
        //    myConnection.Open();
        //    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
        //    myCommand.ExecuteNonQuery();
        //    myConnection.Close();
        //}
    }
    protected void CreateUserWizard1_ActiveStepChanged(object sender, EventArgs e)
    {
        
            if (CreateUserWizard1.ActiveStep.Title == "Your Photo")
            {
                WizardStep ProfileData = CreateUserWizard1.FindControl("ProfileData") as WizardStep;

                // Update the UserProfiles record for this user
                // Get the UserId of the just-added user
                MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
                Guid newUserId = (Guid)newUser.ProviderUserKey;

                // Insert a new record into UserProfiles
                string connectionString =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET City = @City, Hometown = @Hometown, School_College = @School_College, University = @University, Career = @Career, CareerDescription = @CareerDescription WHERE UserId = @UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@City", ((TextBox)ProfileData.FindControl("City")).Text);
                    myCommand.Parameters.AddWithValue("@Hometown", ((TextBox)ProfileData.FindControl("Hometown")).Text);
                    myCommand.Parameters.AddWithValue("@School_College", ((TextBox)ProfileData.FindControl("School_College")).Text);
                    myCommand.Parameters.AddWithValue("@University", ((TextBox)ProfileData.FindControl("University")).Text);
                    myCommand.Parameters.AddWithValue("@Career", ((TextBox)ProfileData.FindControl("Career")).Text);
                    myCommand.Parameters.AddWithValue("@CareerDescription", ((TextBox)ProfileData.FindControl("CareerDescription")).Text);
                    myCommand.Parameters.AddWithValue("@UserId", newUserId);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            
            
            if (CreateUserWizard1.ActiveStep.Title == "Complete")
            {
                
            }

            //string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string insertSql = "INSERT INTO PhotoAlbums(Name, UserId) VALUES(@Name, @UserId)";

            //using (SqlConnection myConnection = new SqlConnection(connectionString2))
            //{
            //    myConnection.Open();
            //    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
            //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
            //    myCommand.Parameters.AddWithValue("@Name", "ProfilePictures");

            //    myCommand.ExecuteNonQuery();
            //    myConnection.Close();
            //}

            //string connectionString3 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string insertSql2 = "INSERT INTO PhotoAlbums(Name, UserId) VALUES(@Name, @UserId)";

            //using (SqlConnection myConnection = new SqlConnection(connectionString3))
            //{
            //    myConnection.Open();
            //    SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
            //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
            //    myCommand.Parameters.AddWithValue("@Name", "CoverPhotos");

            //    myCommand.ExecuteNonQuery();
            //    myConnection.Close();
            //}

          
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;


                string connectionString =
                ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string updateSql = "UPDATE UserProfiles SET ProfilePicture = @ProfilePicture WHERE UserId = @UserId";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                    if (FileUpload1.HasFile)
                    {
                        HttpPostedFile file = FileUpload1.PostedFile;

                        byte[] data = new byte[file.ContentLength];

                        file.InputStream.Read(data, 0, file.ContentLength);
                        myCommand.Parameters.AddWithValue("@ProfilePicture", data);
                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                    Image1.ImageUrl = "~/ProfileHandler.ashx?userid=" + currentUserId;
                }
            }
        }
        catch { }
    }
    protected void myLogin_LoggingIn(object sender, LoginCancelEventArgs e)
    {

    }
    protected void myLogin_Authenticate(object sender, AuthenticateEventArgs e)
    {
      
    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/index_m.aspx?un=" + CreateUserWizard1.UserName);
    }
}