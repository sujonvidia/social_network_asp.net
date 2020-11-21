using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default4 : System.Web.UI.Page
{
    Guid currentUserId;
    int group; int s = 1;
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
    protected void PO_CurrentDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
       
   
            group = Convert.ToInt32(((Label)e.Item.FindControl("RaceGroupLabel")).Text);
   
      
            GroupNameLabel.Text = (this.Master as MasterPage2).getGroupName(group);

            ((Label)e.Item.FindControl("Serial")).Text = s.ToString()+". ";
            s = s + 1;
     
       
    }
}