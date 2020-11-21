using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    Guid currentUserId;
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
    protected void notificationsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@NotifyTo"].Value = currentUserId;
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {

        string ntype = ((Label)e.Item.FindControl("TypeLabel")).Text;
        if (ntype.Contains("Race"))
        {
            ((HyperLink)e.Item.FindControl("HyperLink1")).NavigateUrl = "~/NotificationRace.aspx?postid=" + ((Label)e.Item.FindControl("PostIdLabel")).Text;

        }
        else if (ntype.Contains("Covert"))
        {
            ((HyperLink)e.Item.FindControl("HyperLink1")).NavigateUrl = "~/NotificationCovert.aspx?postid=" + ((Label)e.Item.FindControl("PostIdLabel")).Text;

        }
        else
        {
            ((HyperLink)e.Item.FindControl("HyperLink1")).NavigateUrl = "~/NotificationPost.aspx?postid=" + ((Label)e.Item.FindControl("PostIdLabel")).Text;

        }

        Label type = (Label)e.Item.FindControl("TypeLabel");
        Label display = (Label)e.Item.FindControl("DisplayType");
        
        if (type.Text == "Post_Comment")
        {
            display.Text = "written a comment on your";
        }
       
        if (type.Text == "Race_Comment")
        {
            display.Text = "written a comment on your race";
        }
        if (type.Text == "Covert_Comment")
        {
            display.Text = "written a comment on your covert";
        }

        if (type.Text == "Covert_Comment_Like")
        {
            display.Text = "liked your comment on covert";
        }
        if (type.Text == "Post_Like")
        {
            display.Text = "liked your";
        }
        if (type.Text == "Comment_Like")
        {
            display.Text = "liked your comment on";
        }

        if (type.Text == "Race_Comment_Like")
        {
            display.Text = "liked your comment on race";
        }
        if (type.Text == "Race_Post_Like")
        {
            display.Text = "liked your race";
        }
        if (type.Text == "Covert_Post_Like")
        {
            display.Text = "liked your covert";
        }
        if (type.Text == "Share_Post")
        {
            display.Text = "liked your shared";
        }
        if (type.Text == "Post_New")
        {
            display.Text = "posted on your profile";
        }
        
    }
    protected string CheckIfTitleExists(string strval)
    {
        DateTime dateAndTime = Convert.ToDateTime(strval);
        string date = dateAndTime.ToShortDateString();
        string title = (string)ViewState["title"];
        if (title == date)
        {
            return string.Empty;
        }
        else
        {
            title = date;
            ViewState["title"] = title;
            return "<br><b>" + title + "</b><br>";
        }
    }
    protected void Unnamed_ServerClick(object sender, EventArgs e)
    {

    }
    protected void notification_click_ServerClick(object sender, EventArgs e)
    {

    }
}