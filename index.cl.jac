import ".styles.global.css";
import from .pages.LoginPage { page as LoginPage }
import from .pages.DashboardPage { page as DashboardPage }
import from .pages.HomePage { page as HomePage }
import from .pages.DestinationsPage { page as DestinationsPage }
import from .pages.ExperiencesPage { page as ExperiencesPage }
import from .pages.StaysPage { page as StaysPage }
import from "@jac/runtime" { AuthGuard, Router, Routes, Route, Navigate }

def:pub AuthGuardRoute() -> JsxElement {
    return <>{AuthGuard("/login")}</>;
}

def:pub ClientApp() -> JsxElement {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/destinations" element={<DestinationsPage />} />
                <Route path="/experiences" element={<ExperiencesPage />} />
                <Route path="/stays" element={<StaysPage />} />
                <Route path="/login" element={<LoginPage />} />
                <Route path="*" element={<Navigate to="/" replace={True} />} />
                <Route element={<AuthGuardRoute />}>
                    <Route path="/dashboard" element={<DashboardPage />} />
                </Route>
            </Routes>
        </Router>
    );
}
