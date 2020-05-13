package com.example.goStudy;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.TextView;

import java.util.ArrayList;

public class WelcomeActivity extends AppCompatActivity {

    boolean Gender ; // false - male , true - female.
    String[] CoursesList;
    boolean[] usersMarkedCourses;   //check boxed that the user marked
    ArrayList<Integer> userItems = new ArrayList<>(); // contain the name of the courses the user choose



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);

        CreateGender();
        CreateNickName();
        CreateUserAverage();
        CreateCurrentYear();
        CreatePastCourses();
        CreateCurrentCourses();
        CreateCurrentSemester();
        CreateNextButton();







    }

    private void CreateNextButton() {
        /**next button, continue to home page. */
        Button nextPage =(Button) findViewById(R.id.nextBtn);
        nextPage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(WelcomeActivity.this, HomeActicity.class);
                startActivity(intent);
            }
        });
        nextPage.setClickable(false);
    }

    private void CreateCurrentSemester() {
        Button semA= (Button)findViewById(R.id.semABtn);
        Button semB=(Button) findViewById(R.id.semBBtn);
    }

    private void CreateCurrentCourses() {
        /**choose current courses dialog */
        Button currentCourses =(Button) findViewById(R.id.currentCoursesBtn);
        CoursesList =getResources().getStringArray(R.array.courses);
        usersMarkedCourses =new boolean[CoursesList.length];
        currentCourses.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder mBuilder = new AlertDialog.Builder(v.getContext());
                mBuilder.setTitle(R.string.choose_your_cuurent_year);
                mBuilder.setMultiChoiceItems(CoursesList, usersMarkedCourses, new DialogInterface.OnMultiChoiceClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which, boolean isChecked) {
                        if(isChecked){
                            if(!userItems.contains(which)){userItems.add(which);}
                        }else{
                            userItems.remove(which);
                        }
                    }
                });
                mBuilder.setCancelable(false);
                mBuilder.setPositiveButton("ok", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        String item="";
                        for(int i=0; i<userItems.size();i++){
                            item=item+ CoursesList[userItems.get(i)];
                        }
                        setText("courses selected: "+item);
//                        userSelectedCourses.setText("courses selected: "+item);
                    }
                });

                mBuilder.setNegativeButton("Dismiss", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });

                mBuilder.setNeutralButton("Clear all", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        for(int i = 0; i< usersMarkedCourses.length; i++){
                            usersMarkedCourses[i]=false;
                            userItems.clear();
                            setText("");
//                            userSelectedCourses.setText("");
                        }
                    }
                });

                AlertDialog mDialog = mBuilder.create();
                mDialog.show();
                setNextPage(true);

            }
        });
    }


    private void CreateCurrentYear() {
        /**Current year */
        Button currYear = (Button) findViewById(R.id.currentYearBtn);
    }

    private void CreateUserAverage() {
        /**user average */
        EditText userAvg =(EditText) findViewById(R.id.averageEditText);
    }

    private void CreateNickName() {
        /**nickname*/
        EditText nickName=(EditText) findViewById(R.id.nickNameEditText);
    }

    private void CreateGender() {
        /**Gender */
        RadioButton male= (RadioButton)findViewById(R.id.maleButton);
        RadioButton female= (RadioButton) findViewById(R.id.femaleButton);
    }

    void setNextPage(boolean enable){
        Button nextPage = (Button) findViewById(R.id.nextBtn);
        if (enable){
            nextPage.setClickable(true);
        }
        else {nextPage.setClickable(false);}
    }

    void setText(String text){
        /** display courses that the user choose , need to be removed*/
        TextView userSelectedCourses =(TextView) findViewById(R.id.textView4);
        userSelectedCourses.setText(text);

    }

    /** Choose Past Courses */
    private void CreatePastCourses() {
        /** past courses */
        Button pastCourses = (Button) findViewById(R.id.pastCoursesBtn);
    }

}

