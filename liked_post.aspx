<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="liked_post.aspx.cs" Inherits="Default2" %>

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
    <div style="background-color: white;margin-left: 0px;margin-top: 43px;width: 960px;
	min-height: 1226.6666666666674px;">
        <asp:DataList ID="DataList1" runat="server" DataKeyField="UserId" DataSourceID="LikeDS">
            <ItemTemplate>
                <table runat="server">
                    <tr>
                        <td style="vertical-align:central">
                              <asp:Image ID="ImageProfile" Width="50" Height="50" runat="server" ImageUrl='<%# "ThumbnailHandlerProfile.ashx?userid=" + Eval("UserId") %>' CssClass="whiteborder" />

            
                <asp:HyperLink ID="LikeUserLabel" runat="server" Text='<%# Eval("LikeUser") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />
              

                <br />
                        </td>
                    </tr>
                </table>
                    
      
            </ItemTemplate>
        </asp:DataList>
        </div>
    <asp:SqlDataSource ID="LikeDS" runat="server" OnSelecting="LikeDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserLikes.LikeId, UserLikes.LikeUser, UserLikes.LikeDate, UserLikes.UserId AS Expr1, UserProfiles.* FROM UserLikes INNER JOIN UserProfiles ON UserLikes.UserId = UserProfiles.UserId WHERE (UserLikes.LikeId = @LikeId)">
        <SelectParameters>
            <asp:Parameter Name="LikeId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>

