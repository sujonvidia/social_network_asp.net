<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login_page_Default" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<link rel="shortcut icon" href="favicon.png">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome To Unweverse</title> 
    <%--<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
<meta name="viewport" content="width=device-width" />--%>
    <script src="../Scripts/jquery-2.1.1.min.js"></script>
    <script>
        function clk() {
            document.getElementById("FileUpload1").click();
        }
    </script>
 
    <style>
    



        .errorcolor{
            color:red;
        }
        .sign{
            padding:0px;
            width:0px;
            height:0px;
        }
    </style>

    
</head>
<body class="bo1">
    
   
    <form id="form1" runat="server">
        
        <div id="headbackground">
   <div id="headwrapper">
         
        <div class="header">


     
        <div class="h1" > UNWEVERSE<img class="img" src="logo.png" <%--style="margin-top: 10px;padding-left: 10px;"--%>/></div>
        <div class="login" >
            <asp:Panel name="log" class="login" runat="server" style="border: 1px solid rgb(255, 255, 255); background: none repeat scroll 0% 0% rgb(233, 243, 252); border-radius: 5px; margin-top: 2px; width: 250px; height: 95px;">
              
                 <asp:Login  ID="myLogin" MembershipProvider="SecuritySqlMembershipProvider" OnLoggedIn="myLogin_LoggedIn" runat="server" style="border-collapse:collapse;border-collapse:collapse;margin-top: 5px;margin-left: 11px;"  OnLoginError="myLogin_LoginError">
                     <LayoutTemplate>
                         <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                             <tr>
                                 <td>
                                     <table cellpadding="0">
                                         <tr>
                                             <td align="center" colspan="2"></td>
                                         </tr>
                                         <tr>
                                             <td align="right">
                                                 <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName"></asp:Label>
                                             </td>
                                             <td>
                                                 <asp:TextBox ID="UserName" runat="server" style="font-size: 15px; padding: 6px; display: block; margin-top: 5px; width: 209px; margin-left: -11px; height: 15px;" placeholder="Email Or UserName" onfocus="this.placeholder=''" onblur="this.placeholder='Email Or UserName'"></asp:TextBox>
                                                 <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"  ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="myLogin">*</asp:RequiredFieldValidator>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td align="right">
                                                 <asp:Label ID="PasswordLabel" runat="server"  AssociatedControlID="Password"></asp:Label>
                                             </td>
                                             <td>
                                                 <asp:TextBox ID="Password" CssClass="pass" runat="server" style="font-size: 15px; padding: 6px; width: 136px; margin-top: -24px; display: block; margin-left: -11px; height: 15px;" TextMode="Password" placeholder="Password" onfocus="this.placeholder=''" onblur="this.placeholder='Password'"></asp:TextBox>
                                                 <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="myLogin">*</asp:RequiredFieldValidator>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td colspan="2">
                                                 <asp:CheckBox ID="RememberMe" runat="server" Text="Remember Me" style="font-size: 14px; margin-top: -22px; margin-left: -9px; display: block;"/>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td align="center" colspan="2" style="color:Red;clear: both;position: fixed;margin-top: -88px;margin-left: -140px;">
                                                 <asp:Literal ID="FailureText" runat="server"  EnableViewState="False"></asp:Literal>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td align="right" colspan="2">
                                                 <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" style="color: white; background-color: rgb(38, 40, 79); margin-top: -60px; margin-right: 0px; display: block; padding: 0px; height: 30px; width: 70px; text-align: center; font-size: 16px;" ValidationGroup="myLogin" />
                                            </td>
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                         </table>
                     </LayoutTemplate>
                 </asp:Login>
            </asp:Panel>
             
        </div>
      </div>
        </div>
        </div>
  
        <div id="bodybackground"> 
       <div id="wrapper">

    
        
             

        <div id="middle">
       <div class="sign">
        <asp:Panel class="reg" runat="server">
            
            <asp:CreateUserWizard ID="CreateUserWizard1" MembershipProvider="SecuritySqlMembershipProvider" runat="server" CreateUserButtonText="Sign UP" ActiveStepIndex="0" OnCreatedUser="CreateUserWizard1_CreatedUser" OnActiveStepChanged="CreateUserWizard1_ActiveStepChanged">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                        <ContentTemplate>
                                    <br />
                              
                                    <h1 align="center" style="color: white; font-size: 40px; margin-left: -235px;">Sign UP For Free</h1>
                            
                                        <asp:TextBox ID="FirstName" runat="server" CssClass="sma" ToolTip="First Name" placeholder="First Name" onfocus="this.placeholder=''" onblur="this.placeholder='First Name'"></asp:TextBox>
                                        <asp:TextBox ID="MiddleName" runat="server" CssClass="sma" ToolTip="Middle Name" placeholder="Middle Name" onfocus="this.placeholder=''" onblur="this.placeholder='Middle Name'"></asp:TextBox>
                                        <asp:TextBox ID="LastName" runat="server" CssClass="sma" ToolTip="Last Name" placeholder="Last Name" onfocus="this.placeholder=''" onblur="this.placeholder='Last Name'"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="errorcolor" runat="server" ControlToValidate="FirstName" ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="errorcolor" runat="server" ControlToValidate="MiddleName" ErrorMessage="Middle Name is required." ToolTip="Middle Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
<asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="errorcolor" runat="server" ControlToValidate="LastName" ErrorMessage="Last Name is required." ToolTip="Last Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            <br />
                                    
                                        <asp:TextBox ID="Email" runat="server" CssClass="bi" ToolTip="Email" placeholder="Email" onfocus="this.placeholder=''" onblur="this.placeholder='Email'"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="EmailRequired" CssClass="errorcolor" runat="server"  ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                    <br />
                                        <asp:TextBox ID="UserName" runat="server" CssClass="bi" ToolTip="UserName" placeholder="User Name" onfocus="this.placeholder=''" onblur="this.placeholder='User Name'"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" CssClass="errorcolor" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                 <br />
                                        
                                          <asp:TextBox runat="server" ID="Password" CssClass="bi" TextMode="Password" ToolTip="Password" placeholder="Password" onfocus="this.placeholder=''" onblur="this.placeholder='Password'" />
  
                                        <asp:RequiredFieldValidator ID="PasswordRequired" CssClass="errorcolor" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                 
                                        <br />
                                        <asp:TextBox runat="server" ID="ConfirmPassword" CssClass="bi" ToolTip="Confirm Password" TextMode="Password" placeholder="Confirm Password" onfocus="this.placeholder=''" onblur="this.placeholder='Confirm Password'" />
  
                                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" CssClass="errorcolor" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                           
                                    <asp:TextBox ID="Question" runat="server" CssClass="bi" ToolTip="Question" placeholder="Security Question" onfocus="this.placeholder=''" onblur="this.placeholder='Security Question'"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="QuestionRequired" CssClass="errorcolor" runat="server" ControlToValidate="Question" ErrorMessage="Security question is required." ToolTip="Security question is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                             <br />
                                    <asp:TextBox ID="Answer" runat="server" CssClass="bi" ToolTip="Answer" placeholder="Security Answer" onfocus="this.placeholder=''" onblur="this.placeholder='Security Answer'"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AnswerRequired" CssClass="errorcolor" runat="server" ControlToValidate="Answer" ErrorMessage="Security answer is required." ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                              <br />
                            <table>
                                <tr>
                                    <td>
                                        <h1 style="color:white">Select Your Birthday</h1>
                                        <asp:DropDownList ID="Day" runat="server" CssClass="sma2" ToolTip="Day">
                                <asp:ListItem>Day</asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                                <asp:ListItem>22</asp:ListItem>
                                <asp:ListItem>23</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>26</asp:ListItem>
                                <asp:ListItem>27</asp:ListItem>
                                <asp:ListItem>28</asp:ListItem>
                                <asp:ListItem>29</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>31</asp:ListItem>
                                    </asp:DropDownList>
                                         
                            <asp:DropDownList ID="Month" runat="server" CssClass="sma2" ToolTip="Month">
                                <asp:ListItem>Month</asp:ListItem>
                                <asp:ListItem>Jan</asp:ListItem>
                                <asp:ListItem>Feb</asp:ListItem>
                                <asp:ListItem>Mar</asp:ListItem>
                                <asp:ListItem>Apr</asp:ListItem>
                                <asp:ListItem>May</asp:ListItem>
                                <asp:ListItem>Jun</asp:ListItem>
                                <asp:ListItem>Jul</asp:ListItem>
                                <asp:ListItem>Aug</asp:ListItem>
                                <asp:ListItem>Sep</asp:ListItem>
                                <asp:ListItem>Oct</asp:ListItem>
                                <asp:ListItem>Nov</asp:ListItem>
                                <asp:ListItem>Dec</asp:ListItem>
                                    </asp:DropDownList>
                                         
                            <asp:DropDownList ID="Year" runat="server" CssClass="sma2" ToolTip="Year">
                                <asp:ListItem>Year</asp:ListItem>
                                <asp:ListItem>2014</asp:ListItem>
                                <asp:ListItem>2013</asp:ListItem>
                                <asp:ListItem>2012</asp:ListItem>
                                <asp:ListItem>2011</asp:ListItem>
                                <asp:ListItem>2010</asp:ListItem>
                                <asp:ListItem>2009</asp:ListItem><asp:ListItem>2008</asp:ListItem><asp:ListItem>2007</asp:ListItem><asp:ListItem>2006</asp:ListItem><asp:ListItem>2005</asp:ListItem><asp:ListItem>2004</asp:ListItem><asp:ListItem>2003</asp:ListItem><asp:ListItem>2002</asp:ListItem><asp:ListItem>2001</asp:ListItem><asp:ListItem>2000</asp:ListItem><asp:ListItem>1999</asp:ListItem><asp:ListItem>1998</asp:ListItem><asp:ListItem>1997</asp:ListItem><asp:ListItem>1996</asp:ListItem><asp:ListItem>1995</asp:ListItem><asp:ListItem>1994</asp:ListItem><asp:ListItem>1993</asp:ListItem><asp:ListItem>1992</asp:ListItem><asp:ListItem>1991</asp:ListItem><asp:ListItem>1990</asp:ListItem><asp:ListItem>1989</asp:ListItem><asp:ListItem>1988</asp:ListItem><asp:ListItem>1987</asp:ListItem><asp:ListItem>1986</asp:ListItem><asp:ListItem>1985</asp:ListItem><asp:ListItem>1984</asp:ListItem><asp:ListItem>1983</asp:ListItem><asp:ListItem>1982</asp:ListItem><asp:ListItem>1981</asp:ListItem><asp:ListItem>1980</asp:ListItem><asp:ListItem>1979</asp:ListItem><asp:ListItem>1978</asp:ListItem><asp:ListItem>1977</asp:ListItem><asp:ListItem>1976</asp:ListItem><asp:ListItem>1975</asp:ListItem><asp:ListItem>1974</asp:ListItem><asp:ListItem>1973</asp:ListItem><asp:ListItem>1972</asp:ListItem><asp:ListItem>1971</asp:ListItem><asp:ListItem>1970</asp:ListItem><asp:ListItem>1969</asp:ListItem><asp:ListItem>1968</asp:ListItem><asp:ListItem>1967</asp:ListItem><asp:ListItem>1966</asp:ListItem><asp:ListItem>1965</asp:ListItem><asp:ListItem>1964</asp:ListItem><asp:ListItem>1963</asp:ListItem><asp:ListItem>1962</asp:ListItem><asp:ListItem>1961</asp:ListItem><asp:ListItem>1960</asp:ListItem><asp:ListItem>1959</asp:ListItem><asp:ListItem>1958</asp:ListItem><asp:ListItem>1957</asp:ListItem><asp:ListItem>1956</asp:ListItem><asp:ListItem>1955</asp:ListItem><asp:ListItem>1954</asp:ListItem><asp:ListItem>1953</asp:ListItem><asp:ListItem>1952</asp:ListItem><asp:ListItem>1951</asp:ListItem><asp:ListItem>1950</asp:ListItem><asp:ListItem>1949</asp:ListItem><asp:ListItem>1948</asp:ListItem><asp:ListItem>1947</asp:ListItem><asp:ListItem>1946</asp:ListItem><asp:ListItem>1945</asp:ListItem><asp:ListItem>1944</asp:ListItem><asp:ListItem>1943</asp:ListItem><asp:ListItem>1942</asp:ListItem><asp:ListItem>1941</asp:ListItem><asp:ListItem>1940</asp:ListItem><asp:ListItem>1939</asp:ListItem><asp:ListItem>1938</asp:ListItem><asp:ListItem>1937</asp:ListItem><asp:ListItem>1936</asp:ListItem><asp:ListItem>1935</asp:ListItem><asp:ListItem>1934</asp:ListItem><asp:ListItem>1933</asp:ListItem><asp:ListItem>1932</asp:ListItem><asp:ListItem>1931</asp:ListItem><asp:ListItem>1930</asp:ListItem><asp:ListItem>1929</asp:ListItem><asp:ListItem>1928</asp:ListItem><asp:ListItem>1927</asp:ListItem><asp:ListItem>1926</asp:ListItem><asp:ListItem>1925</asp:ListItem><asp:ListItem>1924</asp:ListItem><asp:ListItem>1923</asp:ListItem><asp:ListItem>1922</asp:ListItem><asp:ListItem>1921</asp:ListItem><asp:ListItem>1920</asp:ListItem><asp:ListItem>1919</asp:ListItem><asp:ListItem>1918</asp:ListItem><asp:ListItem>1917</asp:ListItem><asp:ListItem>1916</asp:ListItem><asp:ListItem>1915</asp:ListItem><asp:ListItem>1914</asp:ListItem><asp:ListItem>1913</asp:ListItem><asp:ListItem>1912</asp:ListItem><asp:ListItem>1911</asp:ListItem><asp:ListItem>1910</asp:ListItem><asp:ListItem>1909</asp:ListItem><asp:ListItem>1908</asp:ListItem><asp:ListItem>1907</asp:ListItem><asp:ListItem>1906</asp:ListItem><asp:ListItem>1905</asp:ListItem> 
                            </asp:DropDownList>
                                        <br />

                                    <asp:RadioButtonList ID="rblGender" runat="server" style="margin-top: 10px;" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="Male" Selected="False" style="color: white;"></asp:ListItem>
                                        <asp:ListItem Text="Female" Selected="False" style="color: white;"></asp:ListItem>
                                        
                                    </asp:RadioButtonList>
                                    </td>
                                        <td>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rblGender" ErrorMessage="Gender is required." CssClass="errorcolor"  ToolTip="Gender is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                               </td>
                                             </tr>
                                    </table>
                                    <tr>
                                         <td>
                                             <asp:CompareValidator ID="PasswordCompare" CssClass="errorcolor" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                         </td>
                                     </tr>
                             <tr>
                                         <td style="color:Red;">
                                             <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                 </td>
                                     </tr>
                           
                        </ContentTemplate>
                        <CustomNavigationTemplate>
                            <table border="0" cellspacing="5" style="width:100%;height:100%;">
                                <tr align="right">
                                    <td align="left" colspan="0">
                                        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Sign UP for Unweverse" style="height: 30px; width:180px; padding: 5px;background-color: #26284f;color: white;display: block;margin-top: -36px;margin-left: 150px;" ValidationGroup="CreateUserWizard1" />
                                    </td>
                                </tr>
                            </table>
                        </CustomNavigationTemplate>
                    </asp:CreateUserWizardStep>
                   <asp:WizardStep ID="ProfileData" runat="server" StepType="Step" Title="Your Profile">
                    <div class="auto-style1">
                        <div style="text-align: center; color: #FF0000; text-decoration: underline;"><strong>Tell us about yourself</strong></div>
                        <asp:TextBox ID="City" runat="server" CssClass="bi" ToolTip="City" placeholder="City" onfocus="this.placeholder=''" onblur="this.placeholder='City'"></asp:TextBox><br />
                        <asp:TextBox ID="Hometown" runat="server" CssClass="bi" ToolTip="Hometown" placeholder="Hometown" onfocus="this.placeholder=''" onblur="this.placeholder='Hometown'"></asp:TextBox><br />
                        <asp:TextBox ID="School_College" runat="server" CssClass="bi" ToolTip="School/College" placeholder="School/College" onfocus="this.placeholder=''" onblur="this.placeholder='School/College'"></asp:TextBox><br />
                        <asp:TextBox ID="University" runat="server" CssClass="bi" ToolTip="University" placeholder="University" onfocus="this.placeholder=''" onblur="this.placeholder='University'" ></asp:TextBox><br />
                        <asp:TextBox ID="Career" runat="server" CssClass="bi" ToolTip="Career" placeholder="Career" onfocus="this.placeholder=''" onblur="this.placeholder='Career'" ></asp:TextBox><br />
                        <asp:TextBox ID="CareerDescription" runat="server" CssClass="bi" TextMode="MultiLine" ToolTip="About you" placeholder="About you" onfocus="this.placeholder=''" onblur="this.placeholder='About you'" ></asp:TextBox>
                    </div>
                </asp:WizardStep>
                    <asp:WizardStep ID="PhotoData" runat="server" StepType="Step" Title="Your Photo">
                    <div class="auto-style1">
                        <div style="text-align: center; color: #FF0000; text-decoration: underline;"><strong>Upload your Photo</strong></div>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/default-profile-photo.jpg" Width="200" Height="200" /><br />
                      <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="Button1_Click" />
                        <asp:FileUpload ID="FileUpload1" runat="server" Width="100px" />
                    </div>
                </asp:WizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td align="center" colspan="2">Complete</td>
                                </tr>
                                <tr>
                                    <td>Your account has been successfully created.</td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="ContinueButton" runat="server" OnClick="ContinueButton_Click" CausesValidation="False" CommandName="Continue" Text="Continue" ValidationGroup="CreateUserWizard1" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
                <StepNavigationTemplate>
                    <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous" />
                    <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next" />
                </StepNavigationTemplate>
            </asp:CreateUserWizard>
            </asp:Panel>
    </div>
    <div class="det">
        <img src="icons/logo_covert.png" class="size"/>&nbsp;&nbsp; &nbsp;<a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;">Tell Your <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">STORIES</span>. Your Darkest  <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">SECRETS</span>. <br />Show The World Your Name or Be Complete <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">ANONYMOUS</span>.</a><br /><br />
        <img src="icons/logo_race.png" class="size"/>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;"><span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">COMPETE</span> For Your Social <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">STATUS</span>. Compete With <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">ANYONE</span>, <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">EVERYONE</span>. Do What You Do <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">BEST</span> And <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">EARN</span> Your Place.</a><br /><br />
        <img src="icons/profile logo.png" class="size"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;"><span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">CONNECT</span> With Your Friends And Family. <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">CHAT</span>, <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">MESSAGE</span>, <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">SHARE</span> Your World.</a><br /><br />
        <img src="icons/film.png" class="size"/>&nbsp;&nbsp; &nbsp; <a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;">Watch <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">MOVIES</span> For Free. Get F.M. For Free. <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">ENJOY</span> Your World <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">BETTER</span> Then Ever.</a><br /><br />
        <img src="icons/wink.png" class="size"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;">Play The <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">OLDEST GAME</span> Known To Mankind.</a><br /><br />
        <img src="icons/jigsaw.png" class="size"/>&nbsp;&nbsp;&nbsp; &nbsp; <a style="color:#fff8d3;display: block;margin-left: 33px;margin-top: -53px;font-size:13px;">And If You're Not <span style="color: #FFFFFF;font-weight: bold;font-size: 16px;">INTERESTED</span> In These, You Can Always Play <a href="Puzzle/Puzzle.html" style="color: #BDFEFA;font-weight: bold;font-size: 18px; text-decoration:underline;margin-left: 35px;" >JIGSAW</a><br /><br />
    </div>
            </div>
        
        
       </div> 
       </div>
       <div id="footerbackground" style="
     height:70px;
">
         <div id="footerwrapper" style="
    margin-top: 0px;
">
        <div class="footer">
        <h3 class="about" >&nbsp;<a href="about.html" class="hyper-l">About</a>&nbsp;&nbsp;<a href="" class="hyper-l">Language</a>&nbsp;<a href="terms.html" class="hyper-l">Terms</a></h3>
    </div>
       </div>
</div>
      
    </form>
   
</body>
    
</html>
