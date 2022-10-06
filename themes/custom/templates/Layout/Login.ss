<section>
    <form id="form-login">
        <div>
            <label for="user-email">Email</label>
            <input type="email" name="email" id="user-email" placeholder="masukan email">
        </div>
        <button type="button" id="createOTP">Create OTP</button>
    </form>
</section>

<div class="modal" id="modal-totp" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Here's Your TOTP</h5>
                <button type="button" id="close-totp" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="totp-body">
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-verify" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Verify Your OTP</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="verification-body">
                <form id="verification-form" method="post">
                    <input type="hidden" name="user_id" id="user_id" value="">
                    <input type="text" name="verification" id="verificationID">
                    <button type="button" id="submitVerification">Verify OTP</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-status" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Login Status</h5>
                <button type="button" class="btn-close" id="close-status" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="status-body">
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#createOTP').click(function() {
            $.ajax({
                url: "{$BaseHref}login/createOTP",
                type: "POST",
                data: $('#form-login').serialize(),
                async: true,
                success: function(result) {
                    let decResult = $.parseJSON(result);
                    $('#totp-body').html("<img src='"+decResult.uri+"'>");
                    $('#user_id').val(decResult.ID);
                    $('#modal-totp').toggle();
                }
            })
        })

        $('#close-totp').click(function () {
            $('#modal-totp').hide();
            $('#modal-verify').show();
        })

        $('#submitVerification').click(function() {
            $.ajax({
                url: "{$BaseHref}login/verifyOTP",
                type: "POST",
                data: $('#verification-form').serialize(),
                async: true,
                success: function(result) {
                    $('#modal-verify').hide();
                    if (result == 200) {
                        $('#status-body').html("Sukses");
                    }else{
                        $('#status-body').html("Gagal");
                    }
                    $('#modal-status').show();
                }
            })
        })

        $('#close-status').click(function () {
            $('#modal-status').hide();
        })
    })    
</script>