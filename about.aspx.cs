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
    Guid currentUserId; string interested;
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
    }
    protected void ProfileDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = user_id;
    }
    protected void ListView1_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        ListView lst = sender as ListView;

        DropDownList ddl = lst.Items[e.ItemIndex].FindControl("GenderTextBox") as DropDownList;
        ProfileDS.UpdateParameters["Gender"].DefaultValue = ddl.SelectedValue;
        DropDownList ddlDay = lst.Items[e.ItemIndex].FindControl("Day") as DropDownList;
        DropDownList ddlMonth = lst.Items[e.ItemIndex].FindControl("Month") as DropDownList;
        DropDownList ddlYear = lst.Items[e.ItemIndex].FindControl("Year") as DropDownList;
        ProfileDS.UpdateParameters["Day"].DefaultValue = ddlDay.SelectedValue;
        ProfileDS.UpdateParameters["Month"].DefaultValue = ddlMonth.SelectedValue;
        ProfileDS.UpdateParameters["Year"].DefaultValue = ddlYear.SelectedValue;

        CheckBoxList cbl = lst.Items[e.ItemIndex].FindControl("InterestedCheckBox") as CheckBoxList;
        //IEnumerable<string> CheckedItems = cbl.Items.Cast<ListItem>()
        //                           .Where(i => i.Selected)
        //                           .Select(i => i.Value);
        //foreach (string i in CheckedItems){
        //    string s1 = i;
        //}
        int numSelected = 0;
        foreach (ListItem li in cbl.Items)
        {
            if (li.Selected)
            {
                numSelected = numSelected + 1;
            }
        }
        if (numSelected == 0)
        {
            interested = "None";
            ProfileDS.UpdateParameters["Interested"].DefaultValue = interested;
        }
        if (numSelected == 1)
        {
            if (cbl.Items[0].Selected)
            {
                interested = cbl.Items[0].Text;
                ProfileDS.UpdateParameters["Interested"].DefaultValue = interested;
            }
            if (cbl.Items[1].Selected)
            {
                interested = cbl.Items[1].Text;
                ProfileDS.UpdateParameters["Interested"].DefaultValue = interested;
            }
        }
        if (numSelected == 2)
        {
            interested = "Male and Female";
            ProfileDS.UpdateParameters["Interested"].DefaultValue = interested;
        }
        DropDownList ddlRelationship = lst.Items[e.ItemIndex].FindControl("ddlRelationship") as DropDownList;
        ProfileDS.UpdateParameters["Relationship"].DefaultValue = ddlRelationship.SelectedValue;
    }
    protected void btnVideo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/videos.aspx?un=" + user_name);
    }
    protected void btnPhoto_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/photos.aspx?un=" + user_name);
    }

    protected void btnAbout_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/about.aspx?un=" + user_name);
    }
    protected void btnFriend_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/friends.aspx?un=" + user_name);

    }
    protected void WorkEducationDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = user_id;
    }
    protected void ContactInfoDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = user_id;
    }
    protected void ProfileDS_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        e.Command.Parameters.Add(new SqlParameter("@UserId", currentUserId));
    }
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (currentUserId.ToString() != user_id.ToString())
        {
            e.Item.FindControl("EditButton").Visible = false;
        }
    }
    protected void WorkEducationDS_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void ContactInfoDS_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void ListView2_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (currentUserId.ToString() != user_id.ToString())
        {
            e.Item.FindControl("EditButton").Visible = false;
        }
    }
    protected void ListView3_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (currentUserId.ToString() != user_id.ToString())
        {
            e.Item.FindControl("EditButton").Visible = false;
        }
    }
}