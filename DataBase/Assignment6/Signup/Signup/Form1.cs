using Microsoft.VisualBasic.ApplicationServices;
using System;
using System.Windows.Forms;
using ZstdSharp.Unsafe;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace Signup
{
    public partial class signup : Form
    {


        public signup()
        {
            InitializeComponent();
        }

        private void submit_Click(object sender, EventArgs e)
        {
            infoDAO infor = new infoDAO();


            if (!string.IsNullOrWhiteSpace(Userlogin.Text) && !string.IsNullOrWhiteSpace(UserPass.Text))
            {
               
                int userId = infor.GetUserId(Userlogin.Text, UserPass.Text);
                if (userId > 0)
                {
                    MessageBox.Show("Login successful.");
                    // Pass the logged-in user's ID to the user page to display their records only
                    userpage newuserpage = new userpage(infor.getUserInfoById(userId));
                    newuserpage.ShowDialog();
                    return;
                }
                else
                {
                    MessageBox.Show("Invalid username or password.");
                    return;
                }
            }


            if (string.IsNullOrWhiteSpace(fname.Text) || string.IsNullOrWhiteSpace(lname.Text) ||
                string.IsNullOrWhiteSpace(sxCombo.Text) || string.IsNullOrWhiteSpace(email.Text) ||
                string.IsNullOrWhiteSpace(occupation.Text))
            {
                MessageBox.Show("Please fill all the fields in personal information");
                return;
            }

          
            if (string.IsNullOrWhiteSpace(SignupUser.Text) || string.IsNullOrWhiteSpace(SignupPass.Text) ||
                string.IsNullOrWhiteSpace(SignupPassCheck.Text))
            {
                MessageBox.Show("Please fill all the fields in signup");
                return;
            }

            // Check if the passwords match
            if (SignupPass.Text != SignupPassCheck.Text)
            {
                MessageBox.Show("Your passwords do not match");
                return;
            }

            // Create a new info object with the form data
            string dateValue = birthDatePick.Value.ToString("yyyy-MM-dd");
            info a1 = new info()
            {
                fName = fname.Text,
                LName = lname.Text,
                Sex = sxCombo.Text,
                Bdate = dateValue,
                Email = email.Text,
                Occup = occupation.Text,
                Signup_User = SignupUser.Text,
                Signup_Pass = SignupPass.Text
            };

            if (!infor.IsUsernameUnique(SignupUser.Text))
            {
                MessageBox.Show("The username already exists, please choose a different username.");
                return;
            }

            // Check if the password is unique
            if (!infor.IsPasswordUnique(SignupPass.Text))
            {
                MessageBox.Show("The password already exists, please choose a different password.");
                return;
            }

            // Add the new signup record
            int result = infor.addOneRecord(a1);
            if (result > 0)
            {
                MessageBox.Show("New row(s) added.");
                int userId = infor.GetUserId(SignupUser.Text, SignupPass.Text); 

                this.Hide(); 
                userpage newuserpage = new userpage(infor.getUserInfoById(userId));
                newuserpage.ShowDialog();
            }
            else
            {
                MessageBox.Show("An error occurred while adding the record.");
            }
        }


        private void signup_Load(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void label13_Click(object sender, EventArgs e)
        {

        }
    }
}