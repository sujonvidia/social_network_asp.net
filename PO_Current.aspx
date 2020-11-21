<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="PO_Current.aspx.cs" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
        #top_menu{
            display:none;
          
        }
        #page{
            background-color:white;
        }
        #page_position_content{
         
            margin-left: 250px;
            margin-top: 86px;

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
    <div style="
    margin-left: 20px;
    margin-top: -88px;
    padding: 78px;
">
        Point Overview ( Current Group) :
        <br />
          Group Name: <asp:Label ID="GroupNameLabel" runat="server"></asp:Label> <br />
    <asp:DataList ID="DataList1" runat="server" DataSourceID="PO_CurrentDS" DataKeyField="UserId" OnItemDataBound="DataList1_ItemDataBound">
   
             

 
        <ItemTemplate>
          
            <asp:Label ID="Serial" runat="server"></asp:Label>
            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
          
            <asp:Label ID="RaceGroupLabel" runat="server" Text='<%# Eval("RaceGroup") %>' Visible="false" />
<br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="PO_CurrentDS" runat="server" OnSelecting="PO_CurrentDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserId, FirstName, MiddleName, LastName, E_mail, UserName, Gender, Age, Career, CareerDescription, ProfilePicture, CoverPicture, BackgroundPicture, Day, Month, Year, City, Hometown, School_College, University, FullName, MsgFrdLast, Relationship, RaceGroup, RaceRank, IweuTotal FROM UserProfiles WHERE (RaceGroup = (SELECT RaceGroup FROM UserProfiles AS UserProfiles_1 WHERE (UserId = @UserId))) order by IweuTotal desc">
        <SelectParameters>
            <asp:Parameter Name="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
        </div>
</asp:Content>

