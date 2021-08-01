using System;
using System.Windows.Forms;

namespace OnRentVideoSystem
{
    public partial class Booking : Form
    {
        public Booking()
        {
            InitializeComponent();
        }
        int id;
        int cost;
        private void Booking_Load(object sender, EventArgs e)
        {
            Connection.LoadLabel(videoLbl, custLbl);
            Connection.GetRentalData(bookingGV);
            id = -1;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Connection.LoadLabel(videoLbl, custLbl);

            Connection.GetRentalData(bookingGV);
        }
        private void button4_Click(object sender, EventArgs e)
        {
            Customer c = new Customer();
            c.Show();
            this.Hide();
        }
        private void button3_Click(object sender, EventArgs e)
        {
            Video v = new Video();
            v.Show();
            this.Hide();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            Environment.Exit(0);
        }
        private void button5_Click_1(object sender, EventArgs e)
        {
            label6.Text = "Select Customer";
            panel6.Visible = true;
            nameTxt.Text = "";
            titleTxt.Text = "";
            startPK.Value = DateTime.Now;
            endPK.Value = DateTime.Now;
            id = -1;
            Connection.GetRentedData(selectGV);
            selectGV.Columns["Address"].Visible = false;
            selectGV.Columns["ID"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
            Connection.GetRentalData(bookingGV);
        }
        private void button6_Click(object sender, EventArgs e)
        {
            if (nameTxt.Text != "" && id != -1)
            {
                int a = cost * Convert.ToInt32((endPK.Value - startPK.Value).TotalDays);
                if (a == 0)
                    a = cost;
                Connection.UpdateData(nameTxt, titleTxt, startPK, endPK, id.ToString(), a);
                nameTxt.Text = "";
                titleTxt.Text = "";
                startPK.Value = DateTime.Now;
                endPK.Value = DateTime.Now;
                id = -1;
                Connection.GetRentalData(bookingGV);

            }
        }
        private void button7_Click_1(object sender, EventArgs e)
        {
            if (nameTxt.Text != "" && id != -1)
            {
                Connection.DeleteData(id.ToString());
                nameTxt.Text = "";
                titleTxt.Text = "";
                startPK.Value = DateTime.Now;
                endPK.Value = DateTime.Now;
                id = -1;
            }
            Connection.GetRentalData(bookingGV);
        }
        private void bookingGV_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (bookingGV.Columns.Count != 0 && e.RowIndex != -1 && e.ColumnIndex != -1)
            {
                DataGridViewRow row = bookingGV.Rows[e.RowIndex];
                id = Convert.ToInt32(row.Cells["ID"].Value.ToString());
                nameTxt.Tag = row.Cells["CID"].Value.ToString();
                titleTxt.Tag = row.Cells["VID"].Value.ToString();
                nameTxt.Text = row.Cells["Customer"].Value.ToString();
                titleTxt.Text = row.Cells["Video"].Value.ToString();
                cost = Convert.ToInt32(row.Cells["Cost"].Value.ToString());
                startPK.Text = row.Cells["Booking Date"].Value.ToString();
                endPK.Text = row.Cells["Return Date"].Value.ToString();
            }
        }
        private void bookingGV_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (bookingGV.Columns.Count != 0 && e.RowIndex != -1 && e.ColumnIndex != -1)
            {
                panel5.Visible = true;
                saveBtn.Text = "Return";
                DataGridViewRow row = bookingGV.Rows[e.RowIndex];
                id = Convert.ToInt32(row.Cells["ID"].Value.ToString());
                nameTxt.Tag = row.Cells["CID"].Value.ToString();
                titleTxt.Tag = row.Cells["VID"].Value.ToString();
                nameTxt.Text = row.Cells["Customer"].Value.ToString();
                titleTxt.Text = row.Cells["Video"].Value.ToString();
                cost = Convert.ToInt32(row.Cells["Cost"].Value.ToString());
                startPK.Text = row.Cells["Booking Date"].Value.ToString();
                endPK.Text = row.Cells["Return Date"].Value.ToString();
            }
        }
        private void button8_Click(object sender, EventArgs e)
        {
            if (nameTxt.Text != "")
            {
                if (saveBtn.Text == "Return")
                {
                    if (id != -1)
                    {
                        int a = cost * Convert.ToInt32((endPK.Value - startPK.Value).TotalDays);
                        if (a == 0)
                            a = cost;
                        Connection.UpdateData(nameTxt, titleTxt, startPK, endPK, id.ToString(), a);
                        nameTxt.Text = "";
                        titleTxt.Text = "";
                        startPK.Value = DateTime.Now;
                        endPK.Value = DateTime.Now;
                        id = -1;
                    }
                }
                else
                {
                    if (nameTxt.Text != "")
                    {
                        Connection.AddData(nameTxt, titleTxt, startPK, endPK);
                        nameTxt.Text = "";
                        titleTxt.Text = "";
                        startPK.Value = DateTime.Now;
                        endPK.Value = DateTime.Now;
                        id = -1;
                    }
                }
                Connection.GetRentalData(bookingGV);
            }
        }
        private void button9_Click(object sender, EventArgs e)
        {
            panel5.Visible = false;
            panel6.Visible = false;
        }
        private void button10_Click_1(object sender, EventArgs e)
        {
            panel6.Visible = false;
        }
        private void dataGridView2_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (selectGV.Columns.Count != 0 && e.RowIndex != -1 && e.ColumnIndex != -1)
            {
                DataGridViewRow row = selectGV.Rows[e.RowIndex];
                if (label6.Text == "Select Video")
                {
                    titleTxt.Text = row.Cells["Title"].Value.ToString();
                    titleTxt.Tag = row.Cells["ID"].Value.ToString();
                    panel5.Visible = true;
                    saveBtn.Text = "Issue";
                }
                else if (label6.Text == "Select Customer")
                {
                    nameTxt.Text = row.Cells["Name"].Value.ToString();
                    nameTxt.Tag = row.Cells["ID"].Value.ToString();
                    label6.Text = "Select Video";
                    Connection.GetMovieDate(selectGV);
                    selectGV.Columns["Cost"].Visible = false;
                    selectGV.Columns["Ratting"].Visible = false;
                    selectGV.Columns["ID"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                    selectGV.Columns["Year"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                    selectGV.Columns["Copies"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                }
            }
        }
    }
}