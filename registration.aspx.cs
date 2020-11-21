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

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string startupPath = System.AppDomain.CurrentDomain.BaseDirectory;
    }
    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        try
        {
            // Get the UserId of the just-added user
            MembershipUser newUser = Membership.GetUser(RegisterUser.UserName);
            Guid newUserId = (Guid)newUser.ProviderUserKey;

            // Insert a new record into UserProfiles
            string connectionString =
                 ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO UserProfiles(UserId, FullName, Gender, Age, Career, CareerDescription, ProfilePicture, BackgroundPicture) VALUES(@UserId, @FullName, @Gender, @Age, @Career, @CareerDescription, (SELECT * FROM OPENROWSET(BULK N'" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\default-profile-photo.jpg', SINGLE_BLOB) AS image), (SELECT * FROM OPENROWSET(BULK N'" + System.AppDomain.CurrentDomain.BaseDirectory + "images\\default-background-photo.jpg', SINGLE_BLOB) AS image))";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", newUserId);
                myCommand.Parameters.AddWithValue("@FullName", DBNull.Value);
                myCommand.Parameters.AddWithValue("@Gender", DBNull.Value);
                myCommand.Parameters.AddWithValue("@Age", DBNull.Value);
                myCommand.Parameters.AddWithValue("@Career", DBNull.Value);
                myCommand.Parameters.AddWithValue("@CareerDescription", DBNull.Value);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
        catch (Exception ex)
        {
            Membership.DeleteUser(RegisterUser.UserName);
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
    protected void RegisterUser_ActiveStepChanged(object sender, EventArgs e)
    {
        // Have we JUST reached the Complete step?
     if (RegisterUser.ActiveStep.Title == "Complete")
     {
         WizardStep ProfileData = RegisterUser.FindControl("ProfileData") as WizardStep;
 
          // Programmatically reference the TextBox controls
         TextBox txtFullName = ProfileData.FindControl("txtFullName") as TextBox;
         DropDownList ddlGender = ProfileData.FindControl("ddlGender") as DropDownList;
         TextBox txtAge = ProfileData.FindControl("txtAge") as TextBox;
         TextBox txtCareer = ProfileData.FindControl("txtCareer") as TextBox;
         TextBox txtCareerDescription = ProfileData.FindControl("txtCareerDescription") as TextBox;
 
          // Update the UserProfiles record for this user
          // Get the UserId of the just-added user
          MembershipUser newUser = Membership.GetUser(RegisterUser.UserName);
          Guid newUserId = (Guid)newUser.ProviderUserKey;
 
          // Insert a new record into UserProfiles
          string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
          string updateSql = "UPDATE UserProfiles SET FullName = @FullName, Gender = @Gender, Age = @Age, Career = @Career, CareerDescription = @CareerDescription WHERE UserId = @UserId";
 
          using (SqlConnection myConnection = new SqlConnection(connectionString))
          {
               myConnection.Open();
               SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
               myCommand.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
               myCommand.Parameters.AddWithValue("@Gender", ddlGender.SelectedItem.Text.Trim());
               myCommand.Parameters.AddWithValue("@Age", txtAge.Text.Trim());
               myCommand.Parameters.AddWithValue("@Career", txtCareer.Text.Trim());
               myCommand.Parameters.AddWithValue("@CareerDescription", txtCareerDescription.Text.Trim());
               myCommand.Parameters.AddWithValue("@UserId", newUserId);
               myCommand.ExecuteNonQuery();
               myConnection.Close();
          }

          string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
          string insertSql = "INSERT INTO PhotoAlbums(Name, UserId) VALUES(@Name, @UserId)";

          using (SqlConnection myConnection = new SqlConnection(connectionString2))
          {
              myConnection.Open();
              SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
              myCommand.Parameters.AddWithValue("@UserId", newUserId);
              myCommand.Parameters.AddWithValue("@Name", "ProfilePictures");
              
              myCommand.ExecuteNonQuery();
              myConnection.Close();
          }

          string connectionString3 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
          string insertSql2 = "INSERT INTO PhotoAlbums(Name, UserId) VALUES(@Name, @UserId)";

          using (SqlConnection myConnection = new SqlConnection(connectionString3))
          {
              myConnection.Open();
              SqlCommand myCommand = new SqlCommand(insertSql2, myConnection);
              myCommand.Parameters.AddWithValue("@UserId", newUserId);
              myCommand.Parameters.AddWithValue("@Name", "CoverPhotos");

              myCommand.ExecuteNonQuery();
              myConnection.Close();
          }

          //string connectionString4 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
          //string insertSql3 = "INSERT INTO UserCircles(Name, UserId) VALUES(@Name, @UserId)";

          //using (SqlConnection myConnection = new SqlConnection(connectionString4))
          //{
          //    myConnection.Open();
          //    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
          //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
          //    myCommand.Parameters.AddWithValue("@Name", "All");

          //    myCommand.ExecuteNonQuery();
          //    myConnection.Close();
          //}
          //using (SqlConnection myConnection = new SqlConnection(connectionString4))
          //{
          //    myConnection.Open();
          //    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
          //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
          //    myCommand.Parameters.AddWithValue("@Name", "Friends");

          //    myCommand.ExecuteNonQuery();
          //    myConnection.Close();
          //}
          //using (SqlConnection myConnection = new SqlConnection(connectionString4))
          //{
          //    myConnection.Open();
          //    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
          //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
          //    myCommand.Parameters.AddWithValue("@Name", "Family");

          //    myCommand.ExecuteNonQuery();
          //    myConnection.Close();
          //}
          //using (SqlConnection myConnection = new SqlConnection(connectionString4))
          //{
          //    myConnection.Open();
          //    SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
          //    myCommand.Parameters.AddWithValue("@UserId", newUserId);
          //    myCommand.Parameters.AddWithValue("@Name", "Acquaintances");

          //    myCommand.ExecuteNonQuery();
          //    myConnection.Close();
          //}
     }
    }
    protected void RegisterUser_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        if (Context.Items["ErrorMessage"] != null)
        {
           
            e.Cancel = true;
        }
    }
}