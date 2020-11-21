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
    Guid currentUserId;
   public const int a = 500;
   public const int r = 50;
 public  int P, Q, R;
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
    }
    
    public int highest_limit_group(int n)
    {
        int P = a * (int)(Math.Pow(2, n) + (Math.Pow(2, n) - 1));
        return P;
    }
    public int lowest_limit_group(int P)
    {
        int Q = (P - a) / 2;
        return Q;
    }
    public int range_of_group(int P, int Q)
    {
        int R = (P - Q);
        return R;
    }
    public int highest_limit_rank(int R, int m)
    {
        int S = (R / r) * m;
        return S;
    }
    public int lowest_limit_rank(int R, int m)
    {
        int T = (R / r) * (m - 1);
        return T;
    }
    public int range_of_rank(int S, int T)
    {
        int U = S - T;
        return U;
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@MyId"].Value = currentUserId;
    }
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
     Int32 total_iweu= Convert.ToInt32( (((Label)e.Item.FindControl("TotalIweuLabel")).Text));
        Int32 group_num,rank_num;   
        string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
        string selectSql = "select RaceGroup from [UserProfiles] WHERE [UserId]=@UserId";

        using (SqlConnection myConnection = new SqlConnection(connectionString2))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(selectSql, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);


            group_num = (Int32)myCommand.ExecuteScalar();


        

            myConnection.Close();

        }
        string connectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
        string selectSql2 = "select [RaceRank] from [UserProfiles] WHERE [UserId]=@UserId";

        using (SqlConnection myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(selectSql2, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);


            rank_num = (Int32)myCommand.ExecuteScalar();




            myConnection.Close();

        }
        string connectionString3 =
     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string updateSql = "UPDATE [UserProfiles] SET [RaceGroup] = @RaceGroup, RaceRank=@RaceRank, IweuTotal=@IweuTotal WHERE UserId=@UserId";

        using (SqlConnection myConnection = new SqlConnection(connectionString3))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
     
        for (int i = group_num; i < 20; i++)
        {
             P = highest_limit_group(i);
             Q = lowest_limit_group(P);
             R = range_of_group(P, Q);
            if (total_iweu <= P && total_iweu >= Q)
            {
                ((Label)e.Item.FindControl("YourGroupLabel")).Text = (this.Master as MasterPage2).getGroupName(i);
                ((Label)e.Item.FindControl("NextGroupLabel")).Text = (this.Master as MasterPage2).getGroupName(i+1);
                ((Label)e.Item.FindControl("IweuNeedLabel")).Text = (P-total_iweu+1).ToString();
                myCommand.Parameters.AddWithValue("@RaceGroup", i);
                break;
            }
            
        }
        for (int j = rank_num; j <= 50; j++)
        {
            int S = highest_limit_rank(R, j);
            int T = lowest_limit_rank(R, j);
            int U = range_of_rank(S, T);
            if (total_iweu <= S && total_iweu >= T)
            {
                ((Label)e.Item.FindControl("RankLabel")).Text = j.ToString();
                myCommand.Parameters.AddWithValue("@RaceRank", j);
                break;
            }

        }

   
            
       
            myCommand.Parameters.AddWithValue("@IweuTotal", total_iweu);
            myCommand.Parameters.AddWithValue("@UserId", currentUserId);



            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }
    }
}