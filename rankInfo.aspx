<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="rankinfo.aspx.cs" Inherits="Default4" %>

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
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin:100px;">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="ListView1_ItemDataBound">
            <AlternatingItemTemplate>
                <span style="">Column1:
                <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' />
                <br />
<br /></span>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <span style="">Column1:
                <asp:TextBox ID="Column1TextBox" runat="server" Text='<%# Bind("Column1") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No data was returned.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">Column1:
                <asp:TextBox ID="Column1TextBox" runat="server" Text='<%# Bind("Column1") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                <br /><br /></span>
            </InsertItemTemplate>
            <ItemTemplate>
                <span style="">
                    Your Group: <asp:Label ID="YourGroupLabel" runat="server" /> <br />
                    Rank: <asp:Label ID="RankLabel" runat="server" /> <br />
                    Iweus: <asp:Label ID="TotalIweuLabel" runat="server" Text='<%# Eval("Column1") %>' />    <br />
                     Next Group: <asp:Label ID="NextGroupLabel" runat="server" /> <br />
                     Iweu need to move: <asp:Label ID="IweuNeedLabel" runat="server" Text='<%# Eval("Column1") %>' /> <br />
            
<br /></span>
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <span style="">Column1:
                <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' />
                <br />
<br /></span>
            </SelectedItemTemplate>
        </asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelecting="SqlDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT SUM(Iweu) FROM RacePoints WHERE (MyId = @MyId)">
        <SelectParameters>
            <asp:Parameter Name="MyId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
        </div>
</asp:Content>

