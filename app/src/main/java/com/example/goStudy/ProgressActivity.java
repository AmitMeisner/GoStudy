package com.example.goStudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ExpandableListView;
import android.widget.ProgressBar;
import android.widget.Spinner;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

public class ProgressActivity extends AppCompatActivity  {

    int wpbCounter =0;
    int spbCounter = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_progress);

        setNavigationButtons();
//        CreateCoursesSpinner();
        CreateWeeklyProgressBar();
        CreateSemesterProgressBar();
        CreateCollapseList();

        /** create choose courses spinner */
        HomeActicity HA = new HomeActicity();
        Spinner coursesSpinner = findViewById(R.id.spr_progressCourses);
        HA.CreateCoursesSpinner(coursesSpinner, ProgressActivity.this);


    }

    private void CreateCollapseList() {
        //collapse goals list
        ExpandableListView expandableListView=findViewById(R.id.weeklyGoalsExpand);
        ExpandableTextViewAdapter adapter = new ExpandableTextViewAdapter(findViewById(R.id.weeklyGoalsExpand).getContext());
        expandableListView.setAdapter(adapter);
    }

    private void CreateSemesterProgressBar() {
        final Timer timerSemester;
        TimerTask timerTaskSemester;
        ProgressBar semesterpb = findViewById(R.id.semesterProgressBar);
        timerSemester = new Timer();
        timerTaskSemester = new TimerTask() {
            @Override
            public void run() {
                spbCounter++;
                semesterpb.setProgress(spbCounter);

                if(spbCounter == 70)
                    timerSemester.cancel();
            }
        };
        timerSemester.schedule(timerTaskSemester,0,50);
    }

    private void CreateWeeklyProgressBar() {
        final Timer timerWeekly;
        TimerTask timerTaskWeekly;
        ProgressBar weeklypb = findViewById(R.id.weeklyProgressBar);
        timerWeekly = new Timer();
        timerTaskWeekly = new TimerTask() {
            @Override
            public void run() {
                wpbCounter++;
                weeklypb.setProgress(wpbCounter);

                if(wpbCounter == 40)
                    timerWeekly.cancel();
            }
        };
        timerWeekly.schedule(timerTaskWeekly,0,50);
    }


    private void setNavigationButtons() {
        FloatingActionButton home= findViewById(R.id.HomeNav);
        FloatingActionButton stat= findViewById(R.id.statNav);
        FloatingActionButton tips= findViewById(R.id.TipsNav);
        FloatingActionButton progress= findViewById(R.id.progNav);

        home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(ProgressActivity.this, HomeActicity.class);
                startActivity(intent);
            }
        });

        stat.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(ProgressActivity.this, StatActivity.class);
                startActivity(intent);
            }
        });

        tips.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(ProgressActivity.this, TipsActivity.class);
                startActivity(intent);
            }
        });

        progress.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(ProgressActivity.this, ProgressActivity.class);
                startActivity(intent);
            }
        });


    }


}
