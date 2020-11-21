<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="notifications.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/master.css"/>
    <style>
        #top_menu{
            display:none;
          
        }
        #page{
            background-color:white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color: white;margin-left: 0px;margin-top: -25px;width: 960px;
	min-height: 1226.6666666666674px;">
    <asp:DataList ID="DataList1" style="color:Black;background-color:White;margin-top: 68px;margin-left: 40px;width: 885px;" runat="server" DataKeyField="UserId" DataSourceID="notificationsDS" OnItemDataBound="DataList1_ItemDataBound">
        <ItemTemplate>
          
       <asp:Label ID="lblTitle" style="padding:5px" runat="server" Text='<%#CheckIfTitleExists(Eval("Date").ToString()) %>'></asp:Label>
           <hr style="border: 1px solid #326ead;" />
                                                <asp:ImageButton ID="ImageProfile" runat="server" style="height: 30px; width: 30px;display:block;" ImageUrl='<%# "ThumbnailHandlerProfile.ashx?userid=" + Eval("UserId") %>' CssClass="whiteborder" />
            <span style="display: block;margin-left: 50px;margin-top: -35px;"> 
            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' /> 
                  
            <asp:Label ID="TypeLabel" style="padding:5px" runat="server" Text='<%# Eval("Type") %>' Visible="false"  />
      

            <asp:Label ID="DisplayType" style="padding:5px" runat="server" Text="Label"></asp:Label>
                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false"></asp:Label>
               <asp:HyperLink ID="HyperLink1" runat="server" Text="post" /> 
            on
            <asp:Label ID="DateLabel" style="padding:5px" runat="server" Text='<%# Eval("Date") %>' />
           </span>
        </ItemTemplate>
        
        
    </asp:DataList>
        </div>
    <asp:SqlDataSource ID="notificationsDS" runat="server" OnSelecting="notificationsDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserProfiles.*, Notifications.*, Notifications.NotifyTo AS Expr1, Notifications.Date AS Expr2 FROM UserProfiles INNER JOIN Notifications ON UserProfiles.UserId = Notifications.UserId WHERE (Notifications.NotifyTo = @NotifyTo and Notifications.MarkasRead=0) ORDER BY Expr2 DESC">
        <SelectParameters>
            <asp:Parameter Name="NotifyTo" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>

