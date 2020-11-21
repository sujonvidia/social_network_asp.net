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
    int value; int iweu;
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
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@MyId"].Value = currentUserId;
    }
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Label iweulbl = e.Item.FindControl("IweuLabel") as Label;


        int.TryParse(iweulbl.Text, out value);
        iweu += value;
        Label totallbl = e.Item.FindControl("TotalLabel") as Label;
        totallbl.Text = iweu.ToString();
    }
}