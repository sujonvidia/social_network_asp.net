<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="myiweu.aspx.cs" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #top_menu{
            display:none;
          
        }
        #page{
            background-color:white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-top: -7px;">
    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="ListView1_ItemDataBound">
        <%--<AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                </td>
                <td>
                    <asp:Label ID="MyIdLabel" runat="server" Text='<%# Eval("MyId") %>' />
                </td>
                <td>
                    <asp:Label ID="ActivityLabel" runat="server" Text='<%# Eval("Activity") %>' />
                </td>
                <td>
                    <asp:Label ID="SubCategoryLabel" runat="server" Text='<%# Eval("SubCategory") %>' />
                </td>
                <td>
                    <asp:Label ID="IweuLabel" runat="server" Text='<%# Eval("Iweu") %>' />
                </td>
                <td>
                    <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>--%>
        <EditItemTemplate>
            <tr style="
    margin-top: 30px;
    margin-left: 395px;
">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                </td>
                <td>
                    <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                </td>
                <td>
                    <asp:TextBox ID="MyIdTextBox" runat="server" Text='<%# Bind("MyId") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ActivityTextBox" runat="server" Text='<%# Bind("Activity") %>' />
                </td>
                <td>
                    <asp:TextBox ID="SubCategoryTextBox" runat="server" Text='<%# Bind("SubCategory") %>' />
                </td>
                <td>
                    <asp:TextBox ID="IweuTextBox" runat="server" Text='<%# Bind("Iweu") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TotalTextBox" runat="server" Text='<%# Bind("Total") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="
    margin-top: 30px;
    margin-left: 395px;
">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                </td>
                <td>
                    <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                </td>
                <td>
                    <asp:TextBox ID="MyIdTextBox" runat="server" Text='<%# Bind("MyId") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ActivityTextBox" runat="server" Text='<%# Bind("Activity") %>' />
                </td>
                <td>
                    <asp:TextBox ID="SubCategoryTextBox" runat="server" Text='<%# Bind("SubCategory") %>' />
                </td>
                <td>
                    <asp:TextBox ID="IweuTextBox" runat="server" Text='<%# Bind("Iweu") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TotalTextBox" runat="server" Text='<%# Bind("Total") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="
    margin-top: 30px;
    margin-left: 395px;
">
                <td>
                     <asp:Label ID="SubCategoryLabel" runat="server" Text='<%# Eval("SubCategory") %>' />
                  
                </td>
                <td>
                     <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PostTitle") %>' />
                  
                </td>
                <td>
                    <asp:Label ID="ActivityLabel" runat="server" Text='<%# Eval("Activity") %>' />
                </td>
              <%--  <td>
                      <asp:Label ID="MyIdLabel" runat="server" Text='<%# Eval("MyId") %>' />
                </td>--%>
                <td>
                    <asp:Label ID="IweuLabel" runat="server" Text='<%# Eval("Iweu") %>' />
                </td>
                <td>
                    <asp:Label ID="TotalLabel" runat="server" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" style="
    margin-top: 50px;
    margin-left: 395px;
    width:500px;
">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="
    
    margin-left: -35px;
    margin-top: 34px;
">
                            
                            <tr runat="server" style >
                                 <th runat="server">SubCategory</th>
                                <th runat="server" >File</th>
                                  <th runat="server">Activity</th>                             
                                <th runat="server">Iweu</th>
                                <th runat="server">Total</th>
                            </tr>
                            
                            
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                            
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                </td>
                <td>
                    <asp:Label ID="MyIdLabel" runat="server" Text='<%# Eval("MyId") %>' />
                </td>
                <td>
                    <asp:Label ID="ActivityLabel" runat="server" Text='<%# Eval("Activity") %>' />
                </td>
                <td>
                    <asp:Label ID="SubCategoryLabel" runat="server" Text='<%# Eval("SubCategory") %>' />
                </td>
                <td>
                    <asp:Label ID="IweuLabel" runat="server" Text='<%# Eval("Iweu") %>' />
                </td>
                <td>
                    <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT RacePoints.RaceId, RacePoints.MyId, RacePoints.Activity, RacePoints.SubCategory, RacePoints.Iweu, RacePoints.Total, RacePosts.PostTitle FROM RacePoints INNER JOIN RacePosts ON RacePoints.RaceId = RacePosts.RaceId WHERE (RacePoints.MyId = @MyId)">
        <SelectParameters>
            <asp:Parameter Name="MyId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
        </div>
</asp:Content>

