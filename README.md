# dbt-Snowflake-Airflow Data Pipeline

A complete, production-ready end-to-end data engineering project demonstrating modern ETL/ELT orchestration with **Apache Airflow**, **dbt**, **Snowflake**, and **Astronomer Cosmos**. This pipeline demonstrates data transformation best practices using the TPC-H benchmark dataset, showcasing staging, transformation, and mart layers.

## 🎯 Project Overview

This project illustrates a professional data pipeline architecture:

- **Data Ingestion**: TPC-H benchmark data loaded into Snowflake.
- **Data Staging**: Raw data cleansed and standardized using dbt staging models.
- **Data Transformation**: Complex business logic applied through fact and intermediate tables.
- **Data Marts**: Aggregated, analysis-ready datasets for BI consumption.
- **Orchestration**: Automated scheduling and dependency management via Apache Airflow.
- **Infrastructure**: Containerized with Docker for easy deployment.

**Key Technologies**: Airflow 2.x, dbt Core, Snowflake, Python, SQL, Docker, Astronomer Cosmos.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Snowflake Data Warehouse                 │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Raw Data Layer (TPC-H Source)                        │   │
│  │ • orders, lineitem, customer, etc.                   │   │
│  └────────────────────┬─────────────────────────────────┘   │
│                       │                                      │
│  ┌────────────────────▼─────────────────────────────────┐   │
│  │ Staging Layer (dbt Views)                            │   │
│  │ • stg_tpch_orders                                    │   │
│  │ • stg_tpch_line_items                                │   │
│  └────────────────────┬─────────────────────────────────┘   │
│                       │                                      │
│  ┌────────────────────▼─────────────────────────────────┐   │
│  │ Intermediate Layer (dbt Views)                       │   │
│  │ • int_order_items                                    │   │
│  │ • int_order_items_summary                            │   │
│  └────────────────────┬─────────────────────────────────┘   │
│                       │                                      │
│  ┌────────────────────▼─────────────────────────────────┐   │
│  │ Marts Layer (dbt Tables)                             │   │
│  │ • fct_orders (Fact table)                            │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                        ▲
                        │
        ┌───────────────┴─────────────────┐
        │                                 │
   ┌────┴─────┐                   ┌──────┴──────┐
   │  Airflow │ (Cosmos)          │  dbt Core   │
   │  Scheduler/              │ (Transformations)
   │  Webserver               │                 │
   └──────────┘               └─────────────────┘
```

---

## 📁 Project Structure

```
dbt-snowflake-airflow/
│
├── README.md                          # This file
├── concepts.md                        # Key concepts & learning notes
│
├── dbt_dag/                           # Main Astronomer Airflow project
│   ├── Dockerfile                     # Docker image with Airflow & dbt
│   ├── requirements.txt                # Python dependencies (Cosmos, dbt-snowflake)
│   ├── packages.txt                    # OS-level packages
│   ├── airflow_settings.yaml          # Local Airflow configuration (secrets)
│   ├── README.md                       # Astronomer boilerplate
│   ├── .gitignore                     # Git exclusions
│   │
│   ├── dags/                          # Airflow DAGs
│   │   ├── dbt_dag.py                # Main dbt DAG (Cosmos integration)
│   │   ├── exampledag.py             # Example Airflow DAG (Astronomer)
│   │   └── dbt/                      # Embedded dbt project
│   │       └── dbt_snowflake_pipeline/
│   │           ├── dbt_project.yml    # dbt project config
│   │           ├── packages.yml       # dbt package dependencies
│   │           ├── package-lock.yml   # Locked versions of dependencies
│   │           │
│   │           ├── models/            # dbt SQL models
│   │           │   ├── staging/       # Raw data staging (views)
│   │           │   │   ├── stg_tpch_orders.sql      # Cleaned orders
│   │           │   │   ├── stg_tpch_line_items.sql  # Cleaned line items
│   │           │   │   └── tpch_sources.yml         # Source definitions
│   │           │   │
│   │           │   └── marts/         # Business-ready tables
│   │           │       ├── fct_orders.sql           # Fact: Orders with aggregates
│   │           │       ├── int_order_items.sql      # Intermediate: Item details
│   │           │       ├── int_order_items_summary.sql  # Intermediate: Item summaries
│   │           │       └── generic_tests.yml        # Test definitions
│   │           │
│   │           ├── macros/            # dbt Jinja macros
│   │           ├── analyses/          # Ad-hoc queries
│   │           ├── seeds/             # Static data files (CSVs)
│   │           ├── snapshots/         # Slowly changing dimensions
│   │           ├── tests/             # dbt singular tests
│   │           ├── logs/              # dbt execution logs
│   │           └── target/            # Compiled dbt artifacts
│   │
│   ├── tests/                         # Airflow DAG tests
│   │   └── dags/
│   │       └── test_dag_example.py   # DAG validation tests (pytest)
│   │
│   ├── include/                       # Additional project files
│   ├── plugins/                       # Custom Airflow plugins
│   └── .astro/                        # Astronomer local configuration
│
├── dbt-env/                           # Python virtual environment (NOT pushed to GitHub)
│   ├── bin/                           # Python executables (dbt, pip, etc.)
│   └── lib/                           # Installed packages
│
└── logs/                              # Runtime logs (NOT pushed to GitHub)
```

---

## 🛠️ Technologies & Tools

| Component | Purpose | Version |
|-----------|---------|---------|
| **Apache Airflow** | Workflow orchestration & scheduling | 2.x |
| **dbt Core** | Data transformation & testing | Latest |
| **Snowflake** | Cloud data warehouse | Any |
| **Astronomer Cosmos** | dbt-Airflow integration | Latest |
| **Docker** | Containerization | 20.x+ |
| **Python** | Programming language | 3.11+ |
| **SQL** | Data transformations | Snowflake dialect |
| **Pytest** | DAG testing | Latest |

---

## 📋 Prerequisites

### Local Development
- **Docker** & **Docker Compose** (for containerized Airflow)
- **Astronomer CLI** (optional, for enhanced local development)
  ```bash
  curl -sSL https://install.astronomer.io | sudo bash
  ```
- **Git** (for version control)
- **macOS, Linux, or WSL2 on Windows**

### Snowflake
- Active **Snowflake account** with a warehouse
- Database and schema created
- User account with permissions to create tables and views
- Network access configured (if using Snowflake from Docker)

### Environment Variables
- `SNOWFLAKE_ACCOUNT`: Your Snowflake account ID (e.g., `xy12345`)
- `SNOWFLAKE_USER`: Snowflake username
- `SNOWFLAKE_PASSWORD`: Snowflake password
- `SNOWFLAKE_WAREHOUSE`: Target warehouse name
- `SNOWFLAKE_DATABASE`: Target database name
- `SNOWFLAKE_SCHEMA`: Target schema name

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/jaisrivastav91/dbt-snowflake-airflow-pipeline.git
cd dbt-snowflake-airflow-pipeline
```

### 2. Configure Environment Variables

Create a `.env` file in `dbt_dag/` with your Snowflake credentials:
```bash
cd dbt_dag
cp .env.example .env  # If provided, or create manually
```

Edit `.env`:
```
SNOWFLAKE_ACCOUNT=xy12345
SNOWFLAKE_USER=your_username
SNOWFLAKE_PASSWORD=your_password
SNOWFLAKE_WAREHOUSE=compute_wh
SNOWFLAKE_DATABASE=dbt_db
SNOWFLAKE_SCHEMA=dbt_schema
```

**Note**: For production, use Airflow Connections or Secrets Manager instead of `.env`.

### 3. Start Airflow Locally (Docker)
```bash
cd dbt_dag
astro dev start
```

This spins up five Docker containers:
- **PostgreSQL**: Airflow metadata database
- **Scheduler**: Monitors and triggers DAGs
- **DAG Processor**: Parses DAG files
- **API Server**: Serves Airflow UI
- **Triggerer**: Handles deferred tasks

Once running:
- **Airflow UI**: http://localhost:8080 (login: `admin` / `admin`)
- **PostgreSQL**: `localhost:5432` (credentials: `postgres` / `postgres`)

### 4. Trigger the dbt DAG

1. Navigate to http://localhost:8080/
2. Find the `dbt_dag` DAG
3. Click "Trigger DAG" to run the pipeline

**Expected behavior**:
- dbt models run in order (staging → intermediates → marts)
- Tables/views created in your Snowflake database
- DAG completes successfully

### 5. Verify Results in Snowflake

Connect to Snowflake and query:
```sql
-- Check staging models
SELECT COUNT(*) FROM dbt_schema.stg_tpch_orders;

-- Check fact table
SELECT * FROM dbt_schema.fct_orders LIMIT 10;
```

---

## 📊 Data Models Explained

### Staging Layer (`staging/`)
**Purpose**: Clean, standardize, and deduplicate raw data. Models are **views** for optimal performance.

#### `stg_tpch_orders.sql`
- Selects key columns from raw `orders` source
- Renames columns for clarity (e.g., `o_orderkey` → `order_key`)
- Removes sensitive/unused fields
- **Output**: View of cleaned order records

#### `stg_tpch_line_items.sql`
- Cleans raw line item data from TPC-H
- Standardizes column names and data types
- **Output**: View of cleaned line items

#### `tpch_sources.yml`
- Defines source tables and columns
- Documents data lineage
- Enables dbt source freshness checks

---

### Intermediate Layer (`marts/int_*`)
**Purpose**: Build reusable intermediate tables without exposing to BI tools. Models are **views** by default.

#### `int_order_items.sql`
- Joins staging orders with line items
- Enriches with derived metrics
- **Output**: Intermediate view of detailed order-item relationships

#### `int_order_items_summary.sql`
- Aggregates line items by order
- Calculates gross sales, discounts, net revenue
- **Output**: Summary-level intermediate view

---

### Mart Layer (`marts/`)
**Purpose**: Deliver analysis-ready, aggregated data for dashboards and BI. Models are **tables** for fast querying.

#### `fct_orders.sql` (Fact Table)
- Joins `stg_tpch_orders` with `int_order_items_summary`
- Combines order details with aggregated item metrics
- **Columns**: `order_key`, `customer_key`, `status_code`, `total_price`, `order_date`, `gross_item_sales_amount`, `item_discount_amount`
- **Output**: Denormalized table optimized for BI

#### `generic_tests.yml`
- Defines dbt tests for data quality
- Validates uniqueness, not-null constraints, referential integrity
- Runs after model builds

---

## 🧪 Testing

### dbt Tests

Run dbt tests locally to validate data quality:
```bash
cd dbt_dag/dags/dbt/dbt_snowflake_pipeline
dbt test --profile dbt_snowflake_pipeline
```

Tests are defined in `generic_tests.yml` and include:
- **Uniqueness**: Ensure primary keys are unique
- **Not Null**: Verify critical columns are not null
- **Referential Integrity**: Check foreign keys reference existing records

### Airflow DAG Tests

Run pytest to validate DAG structure:
```bash
cd dbt_dag
pytest tests/dags/test_dag_example.py
```

**Validation includes**:
- No import errors in DAG files
- DAGs have required tags, retries, owner
- DAG configuration is valid

---

## 🔄 DAG Execution Flow

The `dbt_dag.py` DAG orchestrates dbt transformations:

```
1. DAG Start
   ↓
2. dbt deps (install packages)
   ↓
3. dbt seed (load static data)
   ↓
4. dbt run (execute models in dependency order)
   ├─ stg_tpch_orders (view)
   ├─ stg_tpch_line_items (view)
   ├─ int_order_items (view)
   ├─ int_order_items_summary (view)
   └─ fct_orders (table)
   ↓
5. dbt test (validate results)
   ↓
6. DAG Success
```

**Schedule**: Daily at midnight (configurable in `dbt_dag.py`)

---

## 📦 Dependencies & Packages

### Python Dependencies (`requirements.txt`)
- **astronomer-cosmos**: dbt-Airflow integration
- **apache-airflow-providers-snowflake**: Snowflake connection support

### dbt Packages (`packages.yml`)
- Configured in `dbt_project.yml`; add additional packages as needed

### OS Dependencies (`packages.txt`)
- List OS-level packages (e.g., `build-essential`) if needed

---

## 🐳 Docker Configuration

### Dockerfile
- **Base Image**: Astronomer Runtime 3.2 with Airflow 2.x
- **Custom Setup**: Installs `dbt-snowflake` in a virtual environment within the container
- **dbt venv**: Isolated Python environment for dbt execution

### Building & Running
```bash
# Build custom image
docker build -t my-airflow:latest .

# Run with Astronomer CLI
astro dev start

# Or with Docker Compose directly
docker-compose up -d
```

---

## 🔐 Security Best Practices

### Secrets Management
- **Never commit `.env` files** with credentials
- Use **Airflow Connections** UI: `Admin > Connections > Add New Connection`
  - Connection ID: `snowflake_conn`
  - Connection Type: `Snowflake`
  - Enter host, user, password, database, schema
- Use **Airflow Variables** for non-sensitive config
- For production: Use **AWS Secrets Manager**, **HashiCorp Vault**, or **GitHub Secrets**

### Environment Variables in Airflow
Access in DAGs via:
```python
import os
db = os.environ.get('SNOWFLAKE_DATABASE')
```

---

## 🚢 Deployment

### To Astronomer Platform
If using Astronomer's managed service:
```bash
astro deploy
```

### To External Airflow (Docker/K8s)
1. Ensure Snowflake credentials are in Airflow Connection UI
2. Mount dbt project to Airflow containers
3. Ensure paths match: `/usr/local/airflow/dags/dbt/dbt_snowflake_pipeline`
4. Configure Airflow to scan DAG folder
5. Restart scheduler/webserver

### To Kubernetes
- Build Docker image
- Push to registry
- Use Helm charts or ArgoCD to deploy Airflow
- Configure Snowflake connectivity in K8s Secrets

---

## 🔧 Troubleshooting

### DAG Not Appearing in Airflow UI
**Symptom**: DAG folder scanned, but `dbt_dag` not visible.
**Solution**:
1. Check Airflow logs: `astro dev logs -s scheduler`
2. Verify no Python import errors: `python -m py_compile dags/dbt_dag.py`
3. Ensure `dbt_project.yml` exists at configured path
4. Verify DAG returns valid Airflow DAG object

### Snowflake Connection Error
**Symptom**: DAG fails with connection error.
**Solution**:
1. Verify Snowflake credentials in Airflow Connection UI
2. Test connection: `astro dev bash -s scheduler`
   ```bash
   python -c "import snowflake.connector; print('OK')"
   ```
3. Check Snowflake network policy allows inbound connections
4. Verify warehouse is not suspended

### dbt Model Fails
**Symptom**: DAG fails in dbt run step.
**Solution**:
1. Check dbt logs in Airflow Task Logs
2. Run dbt locally: `dbt debug`, `dbt run`
3. Verify Snowflake warehouse is running
4. Check for syntax errors in SQL models
5. Ensure sources exist in Snowflake

### Port Conflicts
**Symptom**: Error starting Airflow (ports 8080, 5432 in use).
**Solution**:
1. Stop conflicting services: `lsof -i :8080`
2. Configure custom ports in `.env`: `AIRFLOW_WEBSERVER_PORT=8081`
3. Use `astro dev stop && astro dev prune`

---

## 📚 Learning Resources

- **dbt Documentation**: https://docs.getdbt.com
- **Airflow Documentation**: https://airflow.apache.org/docs/
- **Astronomer Cosmos**: https://cosmos.astronomer.io
- **Snowflake Documentation**: https://docs.snowflake.com
- **TPC-H Benchmark**: http://www.tpc.org/tpch/

---

## 📝 Key Concepts Covered

The project demonstrates:
- **Snowflake RBAC** (roles, warehouses, schemas, databases)
- **dbt Project Configuration** (profiles, models, tests)
- **Staging and Source Models** (data lineage, freshness)
- **Fact Tables & Data Marts** (dimensional modeling)
- **dbt Macros & Jinja** (templating, code reuse)
- **Generic & Singular Tests** (data quality validation)
- **Airflow Orchestration** (scheduling, dependencies, error handling)
- **Cosmos Integration** (dbt-native DAG generation)

See `concepts.md` for detailed notes.

---

## 🤝 Contributing

Contributions welcome! To improve this project:

1. **Fork** the repository
2. **Create a feature branch**: `git checkout -b feature/your-feature`
3. **Make changes** and test locally
4. **Commit** with clear messages: `git commit -m "Add new feature"`
5. **Push** to your fork: `git push origin feature/your-feature`
6. **Open a Pull Request** with description of changes

---

## 📄 License

MIT License. See LICENSE file for details.

---

## 👤 Author

**Jai Srivastav** (jaisrivastav91)
- GitHub: https://github.com/jaisrivastav91
- Email: (add your contact if desired)

---

## 📞 Support

For issues, questions, or suggestions:
1. **Check existing GitHub Issues**
2. **Search documentation links above**
3. **Open a new GitHub Issue** with detailed description
4. **Contact**: (add contact method if desired)

---

**Last Updated**: April 30, 2026
**Status**: Production-Ready
