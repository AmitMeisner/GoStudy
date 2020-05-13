package com.example.goStudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.ValueDependentColor;
import com.jjoe64.graphview.series.BarGraphSeries;
import com.jjoe64.graphview.series.DataPoint;

import java.util.ArrayList;

public class StatActivity extends AppCompatActivity {
    GraphView graph_shown;
    BarGraphSeries<DataPoint> weekly_series;
    BarGraphSeries<DataPoint> hw_series;
    BarGraphSeries<DataPoint> lectures_series;
    BarGraphSeries<DataPoint> recitations_series;
    int average;
    EditText average_input_et;
    boolean variable_selected = false;
    boolean average_entered = false;
    boolean course_selected = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_stat);

        setNavigationButtons();
        graph_shown = findViewById(R.id.cmgraph);

        init_graph_dummy_database();
        hide_graph();
        hide_error_msg();

        //init spinners
        init_courses_spinner();
        init_criteria_spinner();

        //enter text initliazation
        average_input_et = findViewById(R.id.average_input);


        //configuring show button. will show when all data is entered.
        Button show_btn = findViewById(R.id.show_botton);
        show_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                average_entered = !isEmpty(average_input_et);

                //Average input is optional, for now.
                boolean validity = variable_selected && course_selected; // && average_entered;
                if (!validity){
                    hide_graph();
                    show_error_msg();
                }else{
                    average = 0; //Raghd: not important for now.
                    show_graph();
                    hide_error_msg();
                }
            }
        });

    }

    private void init_courses_spinner(){
        /*this function initializes the courses spinner via pre-defined courses*/
        //spinner initialization
        Spinner statsSpinner = findViewById(R.id.statsCoursesSpnr);
        ArrayList<String> courses = new ArrayList<>();
        courses.add("Select Course");
        courses.add("Algorithms");
        courses.add("Introduction to CS");
        courses.add("Calculus 2A");
        courses.add("Linear Algebra 2A");
        courses.add("All Courses");

        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(StatActivity.this, android.R.layout.simple_spinner_item, courses);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        statsSpinner.setAdapter(arrayAdapter);

        statsSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String text = (String) parent.getItemAtPosition(position);
                hide_graph();
                if ("Select Course" != text){
                    course_selected = true;
                    update_graph_to_be_shown(text);
                }else{
                    course_selected = false;
                }

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }
    private void init_criteria_spinner(){
        /*this function initializes the criteria spinner via pre-defined criterias.*/

        //spinner initialization
        Spinner statsSpinner = findViewById(R.id.statsSpnr);
        ArrayList<String> courses = new ArrayList<>();
        courses.add("Select Criteria");
        courses.add("Weekly Study Hours");
        courses.add("Percentage of HW Solved");
        courses.add("Percentage of Classes Attended");
        courses.add("Percentage of Recitations Attended");

        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(StatActivity.this, android.R.layout.simple_spinner_item, courses);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        statsSpinner.setAdapter(arrayAdapter);
        statsSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String text = (String) parent.getItemAtPosition(position);
                hide_graph();
                if ("Select Criteria" != text){
                    variable_selected = true;
                    update_graph_to_be_shown(text);
                }else{
                    variable_selected = false;
                }

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }
    private void init_graph_dummy_database(){
        /*this function initializes the dummy database of which the statistical graphs are going
         * to be displayed on screen.*/
        // filling data
        weekly_series = new BarGraphSeries<>(new DataPoint[]{
                new DataPoint(0, 67),
                new DataPoint(3, 65),
                new DataPoint(6, 68),
                new DataPoint(9, 68),
                new DataPoint(12, 72),
                new DataPoint(15, 76),
                new DataPoint(18, 70),
                new DataPoint(21, 76),
                new DataPoint(24, 80),
                new DataPoint(27, 81),
                new DataPoint(30, 85),
                new DataPoint(33, 90),
                new DataPoint(37, 88),
        });

        hw_series = new BarGraphSeries<>(new DataPoint[]{
                new DataPoint(0, 67),
                new DataPoint(10, 64),
                new DataPoint(20, 78),
                new DataPoint(30, 76),
                new DataPoint(40, 78),
                new DataPoint(50, 81),
                new DataPoint(60, 83),
                new DataPoint(70, 82),
                new DataPoint(80, 85),
                new DataPoint(90, 86),
                new DataPoint(100, 92),
        });

        lectures_series = new BarGraphSeries<>(new DataPoint[]{
                new DataPoint(0, 86),
                new DataPoint(10, 73),
                new DataPoint(20, 78),
                new DataPoint(30, 76),
                new DataPoint(40, 79),
                new DataPoint(50, 80),
                new DataPoint(60, 82),
                new DataPoint(70, 84),
                new DataPoint(80, 86),
                new DataPoint(90, 85),
                new DataPoint(100, 80),
        });

        recitations_series = new BarGraphSeries<>(new DataPoint[]{
                new DataPoint(0, 70),
                new DataPoint(10, 75),
                new DataPoint(20, 76),
                new DataPoint(30, 81),
                new DataPoint(40, 79),
                new DataPoint(50, 80),
                new DataPoint(60, 83),
                new DataPoint(70, 84),
                new DataPoint(80, 86),
                new DataPoint(90, 85),
                new DataPoint(100, 90),
        });

        //color of bars

        hw_series.setValueDependentColor(new ValueDependentColor<DataPoint>() {
            @Override
            public int get(DataPoint data) {
                if(data.getX() % 2 ==0){
                    return Color.rgb(00,100,255);
                }
                return Color.rgb(00, 00, 255);
            }

        });
        lectures_series.setValueDependentColor(new ValueDependentColor<DataPoint>() {
            @Override
            public int get(DataPoint data) {
                if(data.getX() % 2 ==0) {
                    return Color.rgb(100, 255, 255);
                }
                return Color.rgb(00, 255, 255);
            }

        });

        weekly_series.setValueDependentColor(new ValueDependentColor<DataPoint>() {
            @Override
            public int get(DataPoint data) {
                if(data.getX() % 2 ==0){
                    return Color.rgb(160,100,100);
                }
                return Color.rgb(20, 100,100);
            }

        });
        recitations_series.setValueDependentColor(new ValueDependentColor<DataPoint>() {
            @Override
            public int get(DataPoint data) {
                if(data.getX() % 2 ==0) {
                    return Color.rgb(00, 255, 100);
                }
                return Color.rgb(00, 255, 0);
            }

        });


        //styling
        weekly_series.setDrawValuesOnTop(true);
        weekly_series.setColor(Color.BLACK);
        weekly_series.setValuesOnTopColor(Color.RED);

        hw_series.setDrawValuesOnTop(true);
        hw_series.setColor(Color.BLACK);
        hw_series.setValuesOnTopColor(Color.RED);

        lectures_series.setDrawValuesOnTop(true);
        lectures_series.setColor(Color.BLACK);
        lectures_series.setValuesOnTopColor(Color.RED);

        recitations_series.setDrawValuesOnTop(true);
        recitations_series.setColor(Color.BLACK);
        recitations_series.setValuesOnTopColor(Color.RED);
    }

    private void hide_graph(){
        graph_shown.setVisibility(View.INVISIBLE);
    }

    private void show_graph(){
        graph_shown.getGridLabelRenderer().setNumHorizontalLabels(10);
        graph_shown.setVisibility(View.VISIBLE);
    }

    private void show_error_msg(){
        TextView error_msg = findViewById(R.id.error_msg_stats);
        error_msg.setVisibility(View.VISIBLE);
    }

    private void hide_error_msg(){
        TextView error_msg = findViewById(R.id.error_msg_stats);
        error_msg.setVisibility(View.INVISIBLE);
    }
    private boolean isEmpty(EditText etText) {
        return etText.getText().toString().trim().length() == 0;
    }

    private void update_graph_to_be_shown(String option){
        /*this function chooses which grahp to be show later on screen based on what is picked in spinner.
        Ugly looking implementation, consider changing.*/
        if (option == "Weekly Study Hours"){
            set_weekly_hours_graph_axis();
            graph_shown.removeAllSeries();
            graph_shown.addSeries(weekly_series);
        }
        if (option == "Percentage of HW Solved"){
            set_percenage_graph_axis();
            graph_shown.removeAllSeries();
            graph_shown.addSeries(hw_series);
        }
        if (option == "Percentage of Classes Attended"){
            set_percenage_graph_axis();
            graph_shown.removeAllSeries();
            graph_shown.addSeries(lectures_series);
        }
        if (option == "Percentage of Recitations Attended"){
            set_percenage_graph_axis();
            graph_shown.removeAllSeries();
            graph_shown.addSeries(recitations_series);
        }

        graph_shown.getViewport().setScalable(true);
        graph_shown.getViewport().setScrollable(true);

    }
    private void set_percenage_graph_axis(){
        /*function that limits the X-axis and Y-axis of percentage-type criteria.*/
        graph_shown.getViewport().setMinX(0);
        graph_shown.getViewport().setMaxX(100);
        graph_shown.getViewport().setMinY(40);
        graph_shown.getViewport().setMaxY(100);
        graph_shown.getViewport().setYAxisBoundsManual(true);
        graph_shown.getViewport().setXAxisBoundsManual(true);
    }

    private void set_weekly_hours_graph_axis(){
        /*function that limits/configures the X0axis and Y-axis of weekly hours criteria.*/
        graph_shown.getViewport().setMinX(0);
        graph_shown.getViewport().setMaxX(50);
        graph_shown.getViewport().setMinY(40);
        graph_shown.getViewport().setMaxY(100);
        graph_shown.getViewport().setYAxisBoundsManual(true);
        graph_shown.getViewport().setXAxisBoundsManual(true);
    }

    private void setNavigationButtons() {
        FloatingActionButton home= findViewById(R.id.HomeNav);
        FloatingActionButton stat= findViewById(R.id.statNav);
        FloatingActionButton tips= findViewById(R.id.TipsNav);
        FloatingActionButton progress= findViewById(R.id.progNav);

        home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(StatActivity.this, HomeActicity.class);
                startActivity(intent);
            }
        });

        stat.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(StatActivity.this, StatActivity.class);
                startActivity(intent);
            }
        });

        tips.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(StatActivity.this, TipsActivity.class);
                startActivity(intent);
            }
        });

        progress.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(StatActivity.this, ProgressActivity.class);
                startActivity(intent);
            }
        });


    }


}
