<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="settings.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/master.css"/>
<style>
    #lightfont{
        color:#5b5959;
    }

           input/**********Admin input style(also used in icon,text fields,buttons)***********/
{
	margin: 0;
	padding: 0;
	border-width: 1px;/*******turn it off to show border. looks good in buttons(view all comment etc.). bad in search box, right-side tabs*******/
	-webkit-transform-origin: left top;
	-ms-transform-origin: left top;
	-o-transform-origin: left top;
	transform-origin: left top;
    border: 1px dotted #808080;
    font-family: inherit;
	font-size: inherit;
	font-style: inherit;
	font-weight: inherit;
    border-radius: 3px; 
    -moz-border-radius: 3px; 
    -webkit-border-radius: 3px; 
}
        .input:focus { 
    outline: none; 
    border: 1px solid #7bc1f7;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px; 
    box-shadow: 0px 0px 8px #7bc1f7; 
    -moz-box-shadow: 0px 0px 8px #7bc1f7; 
    -webkit-box-shadow: 0px 0px 8px #7bc1f7; 
}

input:hover {
    border-radius: 3px;
    -moz-border-radius: 3px; 
    -webkit-border-radius: 3px; 
    box-shadow: 0px 0px 8px #d9d9d9; 
    -moz-box-shadow: 0px 0px 8px #d9d9d9; 
    -webkit-box-shadow: 0px 0px 8px #d9d9d9;
}
    .titlewrite{

        color:#5b5959;
    }

    .descwrite{
        font-weight:bold;
    }
    #u6049{
        height:0px;
    }

    #top_menu{
        display:none;
    }
            a:link/****************on click fucntion*****************/
{
	color: black;
    font-weight:normal;
	text-decoration: none;
}

        a:active/****************on click fucntion*****************/
{
	font-weight:normal;
	text-decoration: none;
}
.ajax__tab_tab{
    background-color:#26284f !important;
    height:auto !important;
    width:100px !important;
    color: white !important;
    font-size:10px !important;
    display:block !important;
    margin-bottom: 20px !important;
    margin-top: 20px !important;

}
.ajax__tab{
    background-color:red  !important;

}

.ajax__tab_xp .ajax__tab_header_verticalleft .ajax__tab_tab{

    background:none !important;
    background-color:#326ead!important;
}
.ajax__tab_xp .ajax__tab_body_verticalleft{
    border:0px !important;
    height:210px !important;
    margin-top:-28px !important;

}

.ajax__tab_xp .ajax__tab_header_verticalleft .ajax__tab_active{
    margin-top: 37px !important;
}


.ajax__tab_outer{
     background:none !important;
     height:auto !important;
}

.ajax__tab_inner{
     background:none !important;
     padding:0px !important;
}

#tr, #td{
    border:1px solid red !important;
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
    <div class="clearfix colelem" id="settings_margin" style="margin-left: 9px;margin-top: 0px;background-color:white;width: 960px;
	min-height: 1226.6666666666674px;" ><!-- column -->
        
        
        <ajaxToolkit:TabContainer runat="server" ActiveTabIndex="2" UseVerticalStripPlacement="true" style="display: block; visibility: visible;margin-top: 20px;">
            <ajaxToolkit:TabPanel runat="server" HeaderText="General"  ID="TabGeneral">
               
                <ContentTemplate>
                     <table cellpadding="0" style="height:30px;width: 840px; margin-left: -8px;">
                                               <tr>
                                                   <td align="center" style="color:White;background-color:#26284F;font-size:0.9em;font-weight:bold;">Account Settings</td>
                                               </tr>
                         </table>
                   <asp:Panel ID="Panel1" runat="server" style="width: 840px; margin-left: -13px;">
            <asp:DetailsView ID="DetailsViewProfile" runat="server" style="height:100px;width: 840px;margin-left: 5px;border-collapse:collapse;" AutoGenerateRows="False" DataSourceID="ProfileGeneralDataSource1" AutoGenerateEditButton="True" >
                <Fields>
                    <asp:BoundField DataField="FullName" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Name:" SortExpression="FullName" >
                    
                  
                    
                    <HeaderStyle CssClass="titlewrite" />
                    <ItemStyle CssClass="descwrite" />
                    
                  
                    
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="Gender" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gender:"  SortExpression="Gender"  >
                      
               
                      
                    <HeaderStyle CssClass="titlewrite" />
                    <ItemStyle CssClass="descwrite" />
                      
               
                      
                    </asp:BoundField>
                    <asp:BoundField DataField="Age" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Age:" SortExpression="Age" >
                    <HeaderStyle CssClass="titlewrite" />
                    <ItemStyle CssClass="descwrite" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Career" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Career:" SortExpression="Career" >
                    <HeaderStyle CssClass="titlewrite" />
                    <ItemStyle CssClass="descwrite" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CareerDescription" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Career Description:" SortExpression="CareerDescription" >
                    <HeaderStyle CssClass="titlewrite" />
                    <ItemStyle CssClass="descwrite" />
                    </asp:BoundField>

                </Fields>
               <RowStyle BorderWidth="1px" BorderStyle="Dotted" BorderColor="Gray" />
                
            </asp:DetailsView>

            <asp:SqlDataSource ID="ProfileGeneralDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnUpdating="ProfileGeneralDataSource1_Updating" SelectCommand="SELECT [FullName], [Gender], [Age], [Career], [CareerDescription] FROM [UserProfiles] WHERE ([UserId] = @UserId)" OnSelecting="ProfileGeneralDataSource1_Selecting" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE UserProfiles SET FullName =@FullName , Gender =@Gender , Age =@Age , Career =@Career  , CareerDescription =@CareerDescription where UserId=@UserId ">
                <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                </SelectParameters>
                <UpdateParameters >
                    <asp:ControlParameter ControlID="DetailsViewProfile"  Name="FullName" PropertyName="DataItem"  />
                    <asp:ControlParameter ControlID="DetailsViewProfile" Name="Gender" PropertyName="DataItem" />
                    <asp:ControlParameter ControlID="DetailsViewProfile" Name="Age" PropertyName="DataItem" />
                    <asp:ControlParameter ControlID="DetailsViewProfile" Name="CareerDescription" PropertyName="DataItem" />
                    <asp:ControlParameter ControlID="DetailsViewProfile" Name="Career" PropertyName="DataItem" />
                   
                </UpdateParameters>
            </asp:SqlDataSource>
                       <br />
                       <br />
                       <asp:DetailsView ID="DetailsViewEmail" runat="server" style="height:10px;width: 840px;margin-left: 5px;border-collapse:collapse;" AutoGenerateRows="False" DataSourceID="emailDataSource1" AutoGenerateEditButton="True">
                           <Fields>
                               <asp:BoundField DataField="Email" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email:" SortExpression="Email" >
                               <HeaderStyle CssClass="titlewrite" />
                               <ItemStyle CssClass="descwrite" />
                               </asp:BoundField>
                           </Fields>
                           <RowStyle BorderWidth="1px" BorderStyle="Dotted" BorderColor="Gray" />
                       </asp:DetailsView>
                       <asp:SqlDataSource ID="emailDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT [Email] FROM [vw_aspnet_MembershipUsers] WHERE ([UserId] = @UserId)" OnSelecting="ProfileGeneralDataSource1_Selecting" UpdateCommand="UPDATE aspnet_Membership SET Email =@Email ">
                           <SelectParameters>
                               <asp:Parameter Name="UserId" Type="Object" />
                           </SelectParameters>
                           <UpdateParameters>
                               <asp:ControlParameter ControlID="DetailsViewEmail" Name="Email" PropertyName="DataItem" />
                           </UpdateParameters>
                       </asp:SqlDataSource>
                       
        </asp:Panel>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
           
            <ajaxToolkit:TabPanel ID="TabPrivacy" runat="server" HeaderText="Privacy">
                <HeaderTemplate>
                    Privacy Settings
                </HeaderTemplate>
                <ContentTemplate>
                    <table cellpadding="0" style="height:30px;width: 840px; margin-left: -8px;">
                                               <tr>
                                                   <td align="center" colspan="2" style="color:White;background-color:#26284F;font-size:0.9em;font-weight:bold;">Your Privacy</td>
                                               </tr>
                         </table>
                    <asp:Panel ID="Panel2" runat="server"></asp:Panel>
                    <span id="lightfont">Who can see my Future Post?</span> 
                    <asp:DropDownList ID="ddlPrivacyPost" runat="server" CssClass="descwrite" OnTextChanged="ddlPrivacyPost_TextChanged" AutoPostBack="true">
                        <asp:ListItem Text="Public"></asp:ListItem>
                        <asp:ListItem Text="Friends"></asp:ListItem>
                        <asp:ListItem Text="Only Me"></asp:ListItem></asp:DropDownList><hr />
                    <span id="lightfont">Who can send you friend request? </span>
                    <asp:DropDownList ID="ddlFrdReqWho" runat="server" CssClass="descwrite" OnTextChanged="ddlFrdReqWho_TextChanged" AutoPostBack="true">
                        <asp:ListItem Text="Everyone"></asp:ListItem>
                        <asp:ListItem Text="Friends of Friends"></asp:ListItem>
                      </asp:DropDownList><hr />
                    <span id="lightfont">Who can look you up using the email address you provided?</span>
                    <asp:DropDownList ID="ddlEmaillookup" runat="server" CssClass="descwrite" OnTextChanged="ddlEmaillookup_TextChanged" AutoPostBack="true">
                        <asp:ListItem Text="Everyone"></asp:ListItem>
                        <asp:ListItem Text="Friends of Friends"></asp:ListItem>
                        <asp:ListItem Text="Friends"></asp:ListItem>
                      </asp:DropDownList><hr />
                      <span id="lightfont">Who can look you up using the phone number you provided?</span>
                    <asp:DropDownList ID="ddlPhonelookup" runat="server" CssClass="descwrite" OnTextChanged="ddlPhonelookup_TextChanged" AutoPostBack="true">
                        <asp:ListItem Text="Everyone"></asp:ListItem>
                        <asp:ListItem Text="Friends of Friends"></asp:ListItem>
                        <asp:ListItem Text="Friends"></asp:ListItem>
                      </asp:DropDownList><hr />
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabSecurity" runat="server" HeaderText="Security" Width="100">
                <ContentTemplate>
                <asp:ChangePassword ID="ChangePassword1" runat="server" style="background-color:white;border-collapse:collapse;margin-left: 4px;margin-top: 15px;" Font-Names="Verdana" Font-Size="0.8em" Height="240px" Width="810px">
                           <CancelButtonStyle BackColor="#FFFBFF" BorderColor="blue" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                           <ChangePasswordButtonStyle BackColor="#FFFBFF" BorderColor="pink" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                           <ChangePasswordTemplate>
                               <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                                   <tr>
                                       <td>
                                           <table cellpadding="0" style="height: 175px;width: 840px;margin-left: -12px;margin-top: -94px;">
                                               <tr>
                                                   <td align="center" colspan="2"style="height:30px;color:White;background-color:#26284F;font-size:12px;font-weight:bold;">Change Your Password</td>
                                               </tr>

                                               <tr>
                                                   <td align="left">
                                                       <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword" CssClass="titlewrite" Font-Size="12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current Password:</asp:Label>
                                                   </td>
                                                  
                                                   <td>
                                                       <asp:TextBox ID="CurrentPassword" BorderStyle="Solid" style="border-width:1px" runat="server" Font-Size="0.8em" Width="190px" Height="15px" TextMode="Password"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                   </td>
                                               </tr>

                                             
                                               <tr>
                                                   <td align="left">
                                                       <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword" CssClass="titlewrite" Font-Size="12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;New Password:</asp:Label>
                                                   </td>
                                                 
                                                   <td>
                                                       <asp:TextBox ID="NewPassword" runat="server" BorderStyle="Solid" style="border-width:1px"  Font-Size="0.8em"  Width="190px" Height="15px" TextMode="Password"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                   </td>
                                               </tr>
                                        

                                              
                                               <tr>
                                                   <td align="left">
                                                       <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword" CssClass="titlewrite" Font-Size="12px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm New Password:</asp:Label>
                                                   </td>
                                                
                                                   <td>
                                                       <asp:TextBox ID="ConfirmNewPassword" BorderStyle="Solid" style="border-width:1px"  runat="server" Font-Size="0.8em"  Width="190px" Height="15px" TextMode="Password"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                                   </td>
                                               </tr>
                          

                                          
                                               <tr>
                                                   <td align="center" colspan="2">
                                                       <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td align="center" colspan="2" style="color:Red;">
                                                       <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td align="left">
                                                       <asp:Button ID="ChangePasswordPushButton" runat="server"  CommandName="ChangePassword"  style="height: 20px;background-color: #26284f;color: white; margin-left: 30px;" Text="Change Password" ValidationGroup="ChangePassword1" />
                                                   </td>
                                                   <td>
                                                       <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" Text="Cancel" />
                                                   </td>
                                               </tr>
                                           </table>
                                       </td>
                                   </tr>
                               </table>
                           </ChangePasswordTemplate>
                           <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                           <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                           <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
                           <TextBoxStyle Font-Size="0.8em" />
                           <TitleTextStyle BackColor="#26284F" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                       </asp:ChangePassword>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
           
        </ajaxToolkit:TabContainer>
      
        

        </div>

</asp:Content>

